Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C1EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:17:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE1721773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LoJVCHLm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OumhfZUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE1721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v036sFognL3l8EGYd15Wx50K8wZLZsgXKRunusMjd6M=; b=LoJVCHLmgOhWAx
	n7naG25qMCmVM32f+3N3LskAIwkIDVJivnRrkABGNwSMFApffqqchKS5At7wIHFtocQ5ARmG3F4uh
	7/D19E+Vblbre911JsxIb4IDemHQlVDINcLbsqOR0E+TWnjgD/Cgxd+GT4mZq2kuEpkI6tEHMBxFE
	2PrY9e40VUG9jmD8hRJ2IIAhb4dWwevvDNGqn/urvXyIF9Rnm0AJQjpK8DOxxg9sGU1axxykrCDs5
	eo6anaX/zMJeDNfsVOAIoyaWRO4odhxFk5bpQ9W6hGUiVCgPN2GuMHJHEcEgwS+t3QZ1FzmqqOpam
	YDc6AEnruOLWBYo6qFOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga1wT-0007N7-I6; Thu, 20 Dec 2018 17:17:01 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga1wQ-0007Lz-2P
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 17:17:00 +0000
Received: by mail-wr1-x441.google.com with SMTP id r10so2551251wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 09:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hSPuEWRRK7wMhu9OfMbHsNDR/FeXcaBZmoLhSCUdMRs=;
 b=OumhfZUkI/U0KQevVpk3cMXgzj5YsX8TR7OYR4S4/L8vudzJ4rsoT0Kz6uG1MhPmy7
 2kLJWgPV4opvutrosIuL9SLIy/zR9txHWAR8peb7+v8VyYjD0QfQojKY8eVv7DzETQy7
 vAVPgLwyJwKtEggfm0B51PoclvvQmGRJPxBiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hSPuEWRRK7wMhu9OfMbHsNDR/FeXcaBZmoLhSCUdMRs=;
 b=IK2ri5qaebIiTsmINfa5N9oud7tSzvXImI13ypwPXnVABV7Kh7SklFXVz93e+KWUk8
 t1xXKdC8X3vrncJqUYTehteKIrxK9WFnh9mCP1IYMMcltXEZIrIS+q2Y/awf6babyH9m
 e6hlhUcdGeXobRmzOIQ4CJtP+nj3f3N0cEF3k5/z1LF0H/+8umToRXHaihIgyRi1O7vF
 +CVY098AEOTSQmwK4wVZXIRZbO0jrXw40v8lpvFV2EA5HiPx0dKretLgGu8XENfXITho
 c3NdefzZ8i6+eRdBGFa+Oc4tbuUeHT1b+Abfv6ug7ayapHBsGBsc6fySkFyHez9ZhljH
 8yRw==
X-Gm-Message-State: AA+aEWYY8actchajxzKwV6i7nBvxRfhYEy3xgLz+rmHJDlXzdvprYt3k
 3UvleVyqMEeacMUAtW8mOP0bfQ==
X-Google-Smtp-Source: AFSGD/X9HwzfwzJfpEHl4DkaDE8vakqF5lkNgW85yvdIQUa6NYwiXkTs5buTByly2RAyMT8t8WSkbA==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr24059134wrm.115.1545326205755; 
 Thu, 20 Dec 2018 09:16:45 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
 by smtp.googlemail.com with ESMTPSA id v132sm8379247wme.20.2018.12.20.09.16.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 09:16:44 -0800 (PST)
Subject: Re: [PATCH v10 16/27] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-17-ulf.hansson@linaro.org>
 <20e1c04b-870f-3213-835d-28724ef4f530@linaro.org>
 <CAPDyKFqwB0X6DwamGqYgYKsGRcZRzStT=o_AL2wGExuOkQ2rgw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fe405425-9d94-9f14-b599-63a709e004cf@linaro.org>
Date: Thu, 20 Dec 2018 18:16:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqwB0X6DwamGqYgYKsGRcZRzStT=o_AL2wGExuOkQ2rgw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_091658_116968_0EBD86B3 
X-CRM114-Status: GOOD (  29.24  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAvMTIvMjAxOCAxNjo0MSwgVWxmIEhhbnNzb24gd3JvdGU6Cj4gT24gVGh1LCAyMCBEZWMg
MjAxOCBhdCAxNTowOSwgRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+
IHdyb3RlOgo+Pgo+PiBPbiAyOS8xMS8yMDE4IDE4OjQ2LCBVbGYgSGFuc3NvbiB3cm90ZToKPj4+
IFRvIGVuYWJsZSB0aGUgT1MgaW5pdGlhdGVkIG1vZGUsIHRoZSBDUFUgdG9wb2xvZ3kgbmVlZHMg
dG8gYmUgZGVzY3JpYmVkCj4+PiB1c2luZyB0aGUgaGllcmFyY2hpY2FsIG1vZGVsIGluIERULiBX
aGVuIHVzZWQsIHRoZSBpZGxlIHN0YXRlIGJpdHMgZm9yIHRoZQo+Pj4gQ1BVIGFyZSBjcmVhdGVk
IGJ5IE9SaW5nIHRoZSBiaXRzIGZvciBQTSBkb21haW4ncyBpZGxlIHN0YXRlLgo+Pj4KPj4+IExl
dCdzIHByZXBhcmUgdGhlIFBTQ0kgZHJpdmVyIHRvIGRlYWwgd2l0aCB0aGlzLCB2aWEgaW50cm9k
dWNpbmcgYSBwZXIgQ1BVCj4+PiB2YXJpYWJsZSBjYWxsZWQgZG9tYWluX3N0YXRlIGFuZCBieSBh
ZGRpbmcgaW50ZXJuYWwgaGVscGVycyB0byByZWFkL3dyaXRlCj4+PiB0aGUgdmFsdWUgb2YgdGhl
IHZhcmlhYmxlLgo+Pgo+PiBXaGF0IGFyZSB0aGUgZG9tYWluIHN0YXRlcyA/IFdoYXQgdmFsdWVz
IGNhbiB0aGV5IGhhdmUgPwo+IAo+IFRoZSBleGlzdGluZyBwc2NpX3Bvd2VyX3N0YXRlLCBhbHNv
IGRlZmluZWQgYXMgYSBwZXIgY3B1IHZhcmlhYmxlLAo+IGNvbnRhaW5zIGZpeGVkIHZhbHVlcyBy
ZWZsZWN0aW5nIHRoZSBjb3JyZXNwb25kaW5nCj4gYXJtLHBzY2ktc3VzcGVuZC1wYXJhbSBmb3Ig
dGhlIGlkbGUgc3RhdGUgaW4gcXVlc3Rpb24uCj4gCj4gVGhpcyBpc24ndCBzdWZmaWNpZW50LCB3
aGVuIHVzaW5nIHRoZSBoaWVyYXJjaGljYWwgQ1BVIHRvcG9sb2d5IGluIERUCj4gYW5kIHdoZW4g
T1NJIG1vZGUgaXMgc3VwcG9ydGVkLCBiZWNhdXNlIG9mIHRoZSB3YXkgd2Ugdm90ZSB3aXRoIHRo
ZQo+IFBTQ0kgQ1BVIHN1c3BlbmQgcGFyYW1ldGVyLiBQYXJ0cyBvZiB0aGlzIHBhcmFtZXRlciBz
aGFsbCBpbmZvcm0gYWJvdXQKPiB3aGF0IHN0YXRlIHRvIGFsbG93IGZvciB0aGUgY2x1c3Rlciwg
d2hpbGUgb3RoZXIgcGFydHMgdGVsbHMgdGhlIHN0YXRlCj4gZm9yIHRoZSBDUFUuCj4gCj4gVGhl
IG5ldyAiZG9tYWluIHN0YXRlcyIgcGVyIENQVSB2YXJpYWJsZSwgZ2V0cyBkeW5hbWljYWxseSBj
aGFuZ2VkCj4gd2hlbiBhY3RpdmVseSB1c2VkIGJ5IGZvbGxvd2luZyBwYXRjaGVzIHRoYXQgaW1w
bGVtZW50cyB0aGUgUFNDSSBQTQo+IGRvbWFpbiBzdXBwb3J0LiBEZXBlbmRpbmcgb24gd2hhdCBz
dGF0ZSB0aGUgUE0gZG9tYWluIHBpY2tzLCB0aGUgZ2VucGQKPiAtPnBvd2VyX29mZigpIGNhbGxi
YWNrIHNldHMgYSBuZXcgImRvbWFpbiBzdGF0ZXMiIHZhbHVlLCByZWZsZWN0aW5nCj4gdGhlIHN0
YXRlIGZvciB0aGUgY2x1c3Rlci4KPiAKPiBEb2VzIGl0IG1ha2VzIHNlbnNlPyBJZiB5b3UgbGlr
ZSwgSSBjYW4gdHJ5IHRvIHVwZGF0ZSB0aGUgY2hhbmdlbG9nIHRvCj4gY2xhcmlmeSB0aGlzPwoK
WWVzLCBpdCBtYWtlcyBzZW5zZS4gTWF5IGJlIGdpdmUgYSBwb2ludGVyIG9yIGFuIGluZm9ybWF0
aW9uIGFib3V0IHRoZQpwYXJhbWV0ZXIgZW5jb2RpbmcgaW4gYWRkaXRpb24gdG8gdGhlIGRlc2Ny
aXB0aW9uIGFib3ZlIGNhbiBoZWxwLgoKCj4+PiBDYzogTGluYSBJeWVyIDxpbGluYUBjb2RlYXVy
b3JhLm9yZz4KPj4+IENvLWRldmVsb3BlZC1ieTogTGluYSBJeWVyIDxsaW5hLml5ZXJAbGluYXJv
Lm9yZz4KPj4+IFNpZ25lZC1vZmYtYnk6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8u
b3JnPgo+Pj4gLS0tCj4+Pgo+Pj4gQ2hhbmdlcyBpbiB2MTA6Cj4+PiAgICAgICAtIFVzZSBfX3Ro
aXNfY3B1X3JlYWR8d3JpdGUoKSByYXRoZXIgdGhhbiB0aGlzX2NwdV9yZWFkfHdyaXRlKCkuCj4+
Pgo+Pj4gLS0tCj4+PiAgZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYyB8IDI2ICsrKysrKysr
KysrKysrKysrKysrKystLS0tCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvcHNj
aS9wc2NpLmMgYi9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5jCj4+PiBpbmRleCA0ZjBjYmM5
NWU0MWIuLjhkYmNkZWNjMmFlNCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvcHNj
aS9wc2NpLmMKPj4+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvcHNjaS9wc2NpLmMKPj4+IEBAIC04
Nyw4ICs4NywxOSBAQCBzdGF0aWMgdTMyIHBzY2lfZnVuY3Rpb25faWRbUFNDSV9GTl9NQVhdOwo+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKFBTQ0lfMV8wX0VYVF9QT1dFUl9TVEFU
RV9JRF9NQVNLIHwgXAo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUFNDSV8xXzBf
RVhUX1BPV0VSX1NUQVRFX1RZUEVfTUFTSykKPj4+Cj4+PiArc3RhdGljIERFRklORV9QRVJfQ1BV
KHUzMiwgZG9tYWluX3N0YXRlKTsKPj4+ICBzdGF0aWMgdTMyIHBzY2lfY3B1X3N1c3BlbmRfZmVh
dHVyZTsKPj4+Cj4+PiArc3RhdGljIGlubGluZSB1MzIgcHNjaV9nZXRfZG9tYWluX3N0YXRlKHZv
aWQpCj4+PiArewo+Pj4gKyAgICAgcmV0dXJuIF9fdGhpc19jcHVfcmVhZChkb21haW5fc3RhdGUp
Owo+Pj4gK30KPj4+ICsKPj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgcHNjaV9zZXRfZG9tYWluX3N0
YXRlKHUzMiBzdGF0ZSkKPj4+ICt7Cj4+PiArICAgICBfX3RoaXNfY3B1X3dyaXRlKGRvbWFpbl9z
dGF0ZSwgc3RhdGUpOwo+Pj4gK30KPj4+ICsKPj4+ICBzdGF0aWMgaW5saW5lIGJvb2wgcHNjaV9o
YXNfZXh0X3Bvd2VyX3N0YXRlKHZvaWQpCj4+PiAgewo+Pj4gICAgICAgcmV0dXJuIHBzY2lfY3B1
X3N1c3BlbmRfZmVhdHVyZSAmCj4+PiBAQCAtMTg3LDYgKzE5OCw4IEBAIHN0YXRpYyBpbnQgcHNj
aV9jcHVfb24odW5zaWduZWQgbG9uZyBjcHVpZCwgdW5zaWduZWQgbG9uZyBlbnRyeV9wb2ludCkK
Pj4+Cj4+PiAgICAgICBmbiA9IHBzY2lfZnVuY3Rpb25faWRbUFNDSV9GTl9DUFVfT05dOwo+Pj4g
ICAgICAgZXJyID0gaW52b2tlX3BzY2lfZm4oZm4sIGNwdWlkLCBlbnRyeV9wb2ludCwgMCk7Cj4+
PiArICAgICAvKiBDbGVhciB0aGUgZG9tYWluIHN0YXRlIHRvIHN0YXJ0IGZyZXNoLiAqLwo+Pj4g
KyAgICAgcHNjaV9zZXRfZG9tYWluX3N0YXRlKDApOwo+Pj4gICAgICAgcmV0dXJuIHBzY2lfdG9f
bGludXhfZXJybm8oZXJyKTsKPj4KPj4gSSB0aGluayB0aGlzIGNoYW5nZSBpcyBhbWJpZ3VvdXM6
Cj4+Cj4+ICAtIGlmIGl0IGlzIGEgY2hhbmdlIG9mIHRoZSBzdGF0ZSBiZWNhdXNlIG9mIHRoZSBj
cHVfb24sIHRoZW4gSSB3YXMKPj4gZXhwZWN0aW5nIGEgc2ltaWxhciBjaGFuZ2UgaW4gY3B1X29m
ZiBhbmQgdGhlIGNoYW5nZSBvbmx5IGlmCj4+IGludm9rZV9wc2NpX2ZuKCkgc3VjY2VlZHMuCj4g
Cj4gWW91IGFyZSByaWdodC4gVGhpcyByYXRoZXIgYmVsb25ncyB0byBwYXRjaCAyNCwgYXMgaXRz
IGludGVudCBpcyB0bwo+IGRlYWwgd2l0aCBDUFUgaG90cGx1Zy4KPiAKPj4KPj4gIC0gaWYgaXQg
aXMgYSBjaGFuZ2UgdG8gdGFrZSBvcHBvcnR1bml0eSBvZiB0aGUgY29kZSBwYXRoIHRvIGluaXRp
YWxpemUKPj4gdGhlIGRvbWFpbiBzdGF0ZSwgSSBzdWdnZXN0IHRvIHJlbW92ZSBpdCBmcm9tIHRo
ZXJlIGFuZCBtYWtlIGl0IHZlcnkKPj4gZXhwbGljaXQgd2l0aCBzdGF0aWMgREVGSU5FX1BFUl9D
UFUodTMyLCBkb21haW5fc3RhdGUpID0geyAwIH07Cj4gCj4gV2Ugc2hvdWxkbid0IG5lZWQgdG8g
ZXhwbGljaXRseSBzZXQgc3RhdGljIHZhcmlhYmxlcyB0byB6ZXJvLCBhcyB0aGF0Cj4gc2hvdWxk
IGJlIG1hbmFnZWQgYnkgdGhlIGNvbXBpbGVyLgoKWWVhaCwgdGhhdCB3YXMgdGhlIHB1cnBvc2Ug
b2YgdGhlICp2ZXJ5IGV4cGxpY2l0KiB3b3JkcywgdGhhdCBpcyB0ZWxsCnRoZSByZWFkZXIsIHRo
ZSBpbml0aWFsaXphdGlvbiByZWxpZXMgb24gdGhlIHN0YXRpYyB2YXJpYWJsZXMgYmVpbmcgc2V0
CnRvIHplcm8uCgo+IExldCBtZSBzaW1wbHkgcmVtb3ZlIHRoZSBjYWxsIHRvICBwc2NpX3NldF9k
b21haW5fc3RhdGUoMCkgYW5kIGluc3RlYWQKPiBjb25zaWRlciBpdCBmb3IgcGF0Y2ggMjQuCgpZ
ZXMsIHN1cmUuCgoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSC
IE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRw
Oi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0
dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xp
bmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
