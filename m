Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C65C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:39:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEDE21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gT11HA3I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3UE84c4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEDE21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0H8ojjZroG0kULpG+49L8Cg7N89RDeAfhi9Du1fKIPE=; b=gT11HA3Imq63NM
	kB4LSryii9on0d01v9ouKCeEvDxQJwACZbU3kpLj4YrKi6xfRGAAX2dk1Xp9jspIe3YQVpXeYGiZ5
	NeZo+z9+Ul0Hr/F1px3FMzAfhRr+72pdM6bgmL0B/4GnFQZxscpVvaDD1ugpqYpPM1gl/SOp+1C2q
	4pGCeM0CtmhtKu6tcCS4W/m0XMbXwnheEM5vWPCiOndMKg3Kiq1KNchau9wHpzP7YyOauYJdzwCe2
	tYg0ki1V0c6sxh5FjSFm0qymu9lxuA6hkUSAYveLTNa7tbaNLDbwsz9tEC2XPHHVkjaPM1kQYJUml
	vueCiyBTplfbL81ccZFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZCml-0006v3-AD; Tue, 18 Dec 2018 10:39:35 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZCmg-0006tz-D9
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:39:33 +0000
Received: by mail-wr1-x442.google.com with SMTP id c14so15376869wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 02:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vdkpDLFMM0k7of4w6g7qyHm6s3TEaG0a7qSnU/OuC1k=;
 b=S3UE84c4+0vxvDogAXa4K+c7In4isGXjFfj84ZVzsdHzNBdlLvL/oExnDOAv0gXAVP
 uorOagc1UB/z7vq1aSvj5eIxV8mDBNJZodqpEhYzL2EvW08aYMma1CcTYOYAUmfGHiHn
 6tzCsuZH+Ouge8oiXfPBS7/3/4yC/uosQR1e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vdkpDLFMM0k7of4w6g7qyHm6s3TEaG0a7qSnU/OuC1k=;
 b=n2dwyZBHx5Yrtq/gkzzdRveYL9F8J8nKyZXXfkj6FXy7dg3J01UIBJdJlgziMqADI0
 aykiDcu7ZmdOtLoAI9xkakQLq8x/NE4LasE+HmJu06pDcXu/8IaTQ9Hr7y09M+e8SDI+
 yiLnO72sutJI9fnllpnQgS5vT6spEEKgtKdDYXpVM2w9fDobMnmBXHfuCiHm4BaPPk3C
 jSvsxnv4a4+j6Ff7+9W0jaGae/sbgER4TUQjFD7DZe63CqdubajuFM2PC3KgS00z+Ll3
 K0AkxobsBys42Dze6pd71dKP5q8aL3gjeIxNLhuCbSphXrlJpgNwEltmpxyJnxy96YvM
 xe3Q==
X-Gm-Message-State: AA+aEWYgI3NWOrYK8BBD+DphqkortkV/R1nCEZ4PMQ2LcW72ZcB2iCFR
 eZBUNEGed9XvBWhY4xlBJYpR8A==
X-Google-Smtp-Source: AFSGD/UIUWry9I61RXOyyIAmYrKy1UDFndompH45nSVHbdKRe5/qBnYorOBSdipU8eRLlVbNEIFpkg==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr14533115wrm.115.1545129557283; 
 Tue, 18 Dec 2018 02:39:17 -0800 (PST)
Received: from [192.168.0.40] (105.50.92.92.rev.sfr.net. [92.92.50.105])
 by smtp.googlemail.com with ESMTPSA id v132sm1862367wme.20.2018.12.18.02.39.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 02:39:16 -0800 (PST)
Subject: Re: [PATCH v10 01/27] PM / Domains: Add generic data pointer to
 genpd_power_state struct
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla
 <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-2-ulf.hansson@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <81caa4b6-d0ac-f351-2ecf-47fb0f7dcc74@linaro.org>
Date: Tue, 18 Dec 2018 11:39:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-2-ulf.hansson@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_023931_356881_80576449 
X-CRM114-Status: GOOD (  26.73  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjkvMTEvMjAxOCAxODo0NiwgVWxmIEhhbnNzb24gd3JvdGU6Cj4gTGV0J3MgYWRkIGEgZGF0
YSBwb2ludGVyIHRvIHRoZSBnZW5wZF9wb3dlcl9zdGF0ZSBzdHJ1Y3QsIHRvIGFsbG93IGEgZ2Vu
cGQKPiBiYWNrZW5kIGRyaXZlciB0byBzdG9yZSBwZXIgc3RhdGUgc3BlY2lmaWMgZGF0YS4gSW4g
b3JkZXIgdG8gaW50cm9kdWNlIHRoZQo+IHBvaW50ZXIsIHdlIGFsc28gbmVlZCB0byBhZG9wdCBo
b3cgZ2VucGQgZnJlZXMgdGhlIGFsbG9jYXRlZCBkYXRhIGZvciB0aGUKPiBkZWZhdWx0IGdlbnBk
X3Bvd2VyX3N0YXRlIHN0cnVjdCwgdGhhdCBpdCBtYXkgYWxsb2NhdGUgYXQgcG1fZ2VucGRfaW5p
dCgpLgo+IAo+IE1vcmUgcHJlY2lzZWx5LCBsZXQncyB1c2UgYW4gaW50ZXJuYWwgZ2VucGQgZmxh
ZyB0byB1bmRlcnN0YW5kIHdoZW4gdGhlCj4gc3RhdGVzIG5lZWRzIHRvIGJlIGZyZWVkIGJ5IGdl
bnBkLiBXaGVuIGZyZWVpbmcgdGhlIHN0YXRlcyBkYXRhIGluCj4gZ2VucGRfcmVtb3ZlKCksIGxl
dCdzIGFsc28gY2xlYXIgdGhlIGNvcnJlc3BvbmRpbmcgZ2VucGQtPnN0YXRlcyBwb2ludGVyCj4g
YW5kIHJlc2V0IHRoZSBnZW5wZC0+c3RhdGVfY291bnQuIEluIHRoaXMgd2F5LCBhIGdlbnBkIGJh
Y2tlbmQgZHJpdmVyCj4gYmVjb21lcyBhd2FyZSBvZiB3aGVuIHRoZXJlIGlzIHN0YXRlIHNwZWNp
ZmljIGRhdGEgZm9yIGl0IHRvIGZyZWUuCj4gCj4gQ2M6IExpbmEgSXllciA8aWxpbmFAY29kZWF1
cm9yYS5vcmc+Cj4gQ28tZGV2ZWxvcGVkLWJ5OiBMaW5hIEl5ZXIgPGxpbmEuaXllckBsaW5hcm8u
b3JnPgo+IFNpZ25lZC1vZmYtYnk6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
Pgo+IC0tLQo+IAo+IENoYW5nZXMgaW4gdjEwOgo+IAktIFVwZGF0ZSB0aGUgcGF0Y2ggYWxsb3cg
YmFja2VuZCBkcml2ZXJzIHRvIGZyZWUgdGhlIHN0YXRlcyBzcGVjaWZpYwo+IAkgIGRhdGEgZHVy
aW5nIGdlbnBkIHJlbW92YWwuIER1ZSB0byB0aGlzIGFkZGVkIGNvbXBsZXhpdHksIEkgZGVjaWRl
ZCB0bwo+IAkgIGtlZXAgdGhlIHBhdGNoIHNlcGFyYXRlLCByYXRoZXIgdGhhbiBmb2xkIGl0IGlu
dG8gdGhlIHBhdGNoIHRoYXQgbWFrZXMKPiAJICB1c2Ugb2YgdGhlIG5ldyB2b2lkIHBvaW50ZXIs
IHdoaWNoIHdhcyBzdWdnZXN0ZWQgYnkgUmFmYWVsLgo+IAktIENsYWltIGF1dGhvcnNoaXAgb2Yg
dGhlIHBhdGNoIGFzIGxvdHMgb2YgY2hhbmdlcyBoYXMgYmVlbiBkb25lIHNpbmNlCj4gCSAgdGhl
IG9yaWdpbmFsIHBpY2sgdXAgZnJvbSBMaW5hIEl5ZXIuCj4gCj4gLS0tCj4gIGRyaXZlcnMvYmFz
ZS9wb3dlci9kb21haW4uYyB8IDggKysrKysrLS0KPiAgaW5jbHVkZS9saW51eC9wbV9kb21haW4u
aCAgIHwgMyArKy0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYyBiL2Ry
aXZlcnMvYmFzZS9wb3dlci9kb21haW4uYwo+IGluZGV4IDdmMzhhOTJiNDQ0YS4uZTI3YjkxZDM2
YTJhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYwo+ICsrKyBiL2Ry
aXZlcnMvYmFzZS9wb3dlci9kb21haW4uYwo+IEBAIC0xNjIwLDcgKzE2MjAsNyBAQCBzdGF0aWMg
aW50IGdlbnBkX3NldF9kZWZhdWx0X3Bvd2VyX3N0YXRlKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFp
biAqZ2VucGQpCj4gIAo+ICAJZ2VucGQtPnN0YXRlcyA9IHN0YXRlOwo+ICAJZ2VucGQtPnN0YXRl
X2NvdW50ID0gMTsKPiAtCWdlbnBkLT5mcmVlID0gc3RhdGU7Cj4gKwlnZW5wZC0+ZnJlZV9zdGF0
ZSA9IHRydWU7Cj4gIAo+ICAJcmV0dXJuIDA7Cj4gIH0KPiBAQCAtMTczNiw3ICsxNzM2LDExIEBA
IHN0YXRpYyBpbnQgZ2VucGRfcmVtb3ZlKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQp
Cj4gIAlsaXN0X2RlbCgmZ2VucGQtPmdwZF9saXN0X25vZGUpOwo+ICAJZ2VucGRfdW5sb2NrKGdl
bnBkKTsKPiAgCWNhbmNlbF93b3JrX3N5bmMoJmdlbnBkLT5wb3dlcl9vZmZfd29yayk7Cj4gLQlr
ZnJlZShnZW5wZC0+ZnJlZSk7Cj4gKwlpZiAoZ2VucGQtPmZyZWVfc3RhdGUpIHsKPiArCQlrZnJl
ZShnZW5wZC0+c3RhdGVzKTsKPiArCQlnZW5wZC0+c3RhdGVzID0gTlVMTDsKPiArCQlnZW5wZC0+
c3RhdGVfY291bnQgPSAwOwoKV2h5IHRoZXNlIHR3byBpbml0aWFsaXphdGlvbnM/IEFmdGVyIGdl
bnBkX3JlbW92ZSwgdGhpcyBzdHJ1Y3R1cmUKc2hvdWxkbid0IGJlIHVzZWQgYW55bW9yZSwgbm8g
PwoKPiArCX0KCkluc3RlYWQgb2YgYSBmbGFnLCByZXBsYWNpbmcgdGhlICdmcmVlJyBwb2ludGVy
IHRvIGEgJ2ZyZWUnIGNhbGxiYWNrCndpbGwgYWxsb3cgdG8ga2VlcCB0aGUgZnJlZSBwYXRoIHNl
bGYtZW5jYXBzdWxhdGVkIGluIGRvbWFpbi5jCgpnZW5wZC0+ZnJlZShnZW5wZC0+c3RhdGVzKTsK
ClBhdGNoIDE4LzI3IGNhbiBmaWxsIHRoaXMgZmllbGQgd2l0aCBpdHMgc3BlY2lmaWMgZnJlZSBw
b2ludGVyLgoKCgo+ICAJcHJfZGVidWcoIiVzOiByZW1vdmVkICVzXG4iLCBfX2Z1bmNfXywgZ2Vu
cGQtPm5hbWUpOwo+ICAKPiAgCXJldHVybiAwOwo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3BtX2RvbWFpbi5oIGIvaW5jbHVkZS9saW51eC9wbV9kb21haW4uaAo+IGluZGV4IDNiNWQ3Mjgw
ZTUyZS4uZjllMDliZDQxNTJjIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvcG1fZG9tYWlu
LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3BtX2RvbWFpbi5oCj4gQEAgLTY5LDYgKzY5LDcgQEAg
c3RydWN0IGdlbnBkX3Bvd2VyX3N0YXRlIHsKPiAgCXM2NCByZXNpZGVuY3lfbnM7Cj4gIAlzdHJ1
Y3QgZndub2RlX2hhbmRsZSAqZndub2RlOwo+ICAJa3RpbWVfdCBpZGxlX3RpbWU7Cj4gKwl2b2lk
ICpkYXRhOwo+ICB9Owo+ICAKPiAgc3RydWN0IGdlbnBkX2xvY2tfb3BzOwo+IEBAIC0xMTAsNyAr
MTExLDcgQEAgc3RydWN0IGdlbmVyaWNfcG1fZG9tYWluIHsKPiAgCXN0cnVjdCBnZW5wZF9wb3dl
cl9zdGF0ZSAqc3RhdGVzOwo+ICAJdW5zaWduZWQgaW50IHN0YXRlX2NvdW50OyAvKiBudW1iZXIg
b2Ygc3RhdGVzICovCj4gIAl1bnNpZ25lZCBpbnQgc3RhdGVfaWR4OyAvKiBzdGF0ZSB0aGF0IGdl
bnBkIHdpbGwgZ28gdG8gd2hlbiBvZmYgKi8KPiAtCXZvaWQgKmZyZWU7IC8qIEZyZWUgdGhlIHN0
YXRlIHRoYXQgd2FzIGFsbG9jYXRlZCBmb3IgZGVmYXVsdCAqLwo+ICsJYm9vbCBmcmVlX3N0YXRl
OyAvKiBGcmVlIHRoZSBzdGF0ZSB0aGF0IHdhcyBhbGxvY2F0ZWQgZm9yIGRlZmF1bHQgKi8KPiAg
CWt0aW1lX3Qgb25fdGltZTsKPiAgCWt0aW1lX3QgYWNjb3VudGluZ190aW1lOwo+ICAJY29uc3Qg
c3RydWN0IGdlbnBkX2xvY2tfb3BzICpsb2NrX29wczsKPiAKCgotLSAKIDxodHRwOi8vd3d3Lmxp
bmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNv
Q3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJv
PiBGYWNlYm9vayB8CjxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwK
PGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
