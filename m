Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB9FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:11:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C2D218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cPc5b8oR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8oGAKky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C2D218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZbAzwZjX8VWUbl7N5Sh+5hRC0IiSNfXr9iihDPFkVOA=; b=cPc5b8oRMqpB5j
	V+FwXOWVoQD/0rCQs+drUHHvek+ajXfnaMSVZE/EhUZgJSTauAy/gs4/rXcEulxTLBcd9Jto1dH0m
	XB6mtZNDT43EFrb3uHA+Z+n/k0m/Gjz2Drq2tLeOlAXEtFo6D+mOZHtwHo+NgHK5tPfpXenQRP+4v
	ianE7/ADAspS5k+FmRkdLH6ENamq0fdQWC1aP+lqYcjNflpBohGDYqFa/BfT3WB0HpitgUmL4IRxT
	fibDAN7otVXEjfzF3c0E/r4xyKvPuMsBT/GJcjx9tTelrhAf5KfLNwxSzqC98mCqqJvS1O8OC1oFl
	T355ZE4uf7mgAgT5j7bA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZy6l-0002qp-3i; Thu, 20 Dec 2018 13:11:23 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZy6d-0002q8-Tk
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 13:11:21 +0000
Received: by mail-wm1-x344.google.com with SMTP id c126so2122556wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 05:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ig7wGYUNzjsLT7kF425ff0qq/YN+nkbjFy7aNFOFU58=;
 b=J8oGAKkyLJWDIDvWEzlXaHy4TtAUTdn3ZbncMuoLL6UkSUjL90GyQ3NapOVpJtUDSL
 cXFiaUtzJeB1sRz9fbh3cnv6YvzDOV8QUvI44pWOk6TqNvcsOK3q2gwobD0OAYEKNzZ5
 meJVNQLiL9az6wIDMvMak6mch4w/0htRu2Zr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ig7wGYUNzjsLT7kF425ff0qq/YN+nkbjFy7aNFOFU58=;
 b=INvGTR8xxOot8aknRlg96lxSwkWJCdSuDmI6+2UFahjfYAk4tVVEVBFl6OnJ2Swci8
 AuJJeS/FMhrutQiFTuADLiRYxZAKlm4H5EAlMDCXckvhNQAwOcgwJRYH4nyz3Rat+qu5
 QZ4nzEsPNxsygKhTZr92Op8gVfZu/aO8qtXEeI5NXKWVEPJrLgRzYn7orHibATz4lmSb
 I9Z3cy7bsAqNUmxbXd828zcDv7Kbv31EM2LGpEwhn6aT0bFHtzufI1rd0U4SfwWwpa2S
 WCvnS7psVWNjzb9QHOyicEE7HI5cv9e0zmYDZ0iFmb47lLcehwUts+z7plwLW+pttBKK
 ATFw==
X-Gm-Message-State: AA+aEWbCcCwcctVmsHvVt/E6SmTXhBBRggzD5N2ZHon/Wsqj6Q1T1/rM
 DfOY5uSlUl1HpC4Ky/GPtzhkLrIglsM=
X-Google-Smtp-Source: AFSGD/XUf3arFVOnOwe5ZBcV2T9oh2ze8OHXHCVm/oeGeOL5IyLuhobkfIsFqo/skIyuhceOxw5A4g==
X-Received: by 2002:a1c:70b:: with SMTP id 11mr11924728wmh.74.1545311463087;
 Thu, 20 Dec 2018 05:11:03 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
 by smtp.googlemail.com with ESMTPSA id y8sm9874493wmg.13.2018.12.20.05.11.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 05:11:02 -0800 (PST)
Subject: Re: [PATCH v10 15/27] drivers: firmware: psci: Announce support for
 OS initiated suspend mode
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla
 <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-16-ulf.hansson@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b333c9db-9ef0-cdba-093e-6735a23ec5f6@linaro.org>
Date: Thu, 20 Dec 2018 14:11:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-16-ulf.hansson@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_051115_972007_CBB040A0 
X-CRM114-Status: GOOD (  23.04  )
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

T24gMjkvMTEvMjAxOCAxODo0NiwgVWxmIEhhbnNzb24gd3JvdGU6Cj4gUFNDSSBmaXJtd2FyZSB2
MS4wKywgc3VwcG9ydHMgdHdvIGRpZmZlcmVudCBtb2RlcyBmb3IgQ1BVX1NVU1BFTkQuIFRoZQo+
IFBsYXRmb3JtIENvb3JkaW5hdGVkIG1vZGUsIHdoaWNoIGlzIHRoZSBkZWZhdWx0IGFuZCBtYW5k
YXRvcnkgbW9kZSwgd2hpbGUKPiBzdXBwb3J0IGZvciB0aGUgT1MgaW5pdGlhdGVkIG1vZGUgaXMg
b3B0aW9uYWwuCj4gCj4gVGhpcyBjaGFuZ2UgaW50cm9kdWNlcyBpbml0aWFsIHN1cHBvcnQgZm9y
IHRoZSBPUyBpbml0aWF0ZWQgbW9kZSwgaW4gd2F5Cj4gdGhhdCBpdCBhZGRzIHRoZSByZWxhdGVk
IFBTQ0kgYml0cyBmcm9tIHRoZSBzcGVjIGFuZCBwcmludHMgYSBtZXNzYWdlIGluCj4gdGhlIGxv
ZyB0byBpbmZvcm0gd2hldGhlciB0aGUgbW9kZSBpcyBzdXBwb3J0ZWQgYnkgdGhlIFBTQ0kgRlcu
Cj4gCj4gQ2M6IExpbmEgSXllciA8aWxpbmFAY29kZWF1cm9yYS5vcmc+Cj4gQ28tZGV2ZWxvcGVk
LWJ5OiBMaW5hIEl5ZXIgPGxpbmEuaXllckBsaW5hcm8ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IFVs
ZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPgoKUmV2aWV3ZWQtYnk6IERhbmllbCBM
ZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPgoKPiAtLS0KPiAKPiBDaGFuZ2VzIGlu
IHYxMDoKPiAJLSBOb25lLgo+IAo+IC0tLQo+ICBkcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5j
IHwgMjEgKysrKysrKysrKysrKysrKysrKystCj4gIGluY2x1ZGUvdWFwaS9saW51eC9wc2NpLmgg
ICAgfCAgNSArKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYyBi
L2RyaXZlcnMvZmlybXdhcmUvcHNjaS9wc2NpLmMKPiBpbmRleCA2YmZhNDdjYmQxNzQuLjRmMGNi
Yzk1ZTQxYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5jCj4gKysr
IGIvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYwo+IEBAIC05NSw2ICs5NSwxMSBAQCBzdGF0
aWMgaW5saW5lIGJvb2wgcHNjaV9oYXNfZXh0X3Bvd2VyX3N0YXRlKHZvaWQpCj4gIAkJCQlQU0NJ
XzFfMF9GRUFUVVJFU19DUFVfU1VTUEVORF9QRl9NQVNLOwo+ICB9Cj4gIAo+ICtzdGF0aWMgaW5s
aW5lIGJvb2wgcHNjaV9oYXNfb3NpX3N1cHBvcnQodm9pZCkKPiArewo+ICsJcmV0dXJuIHBzY2lf
Y3B1X3N1c3BlbmRfZmVhdHVyZSAmIFBTQ0lfMV8wX09TX0lOSVRJQVRFRDsKPiArfQo+ICsKPiAg
c3RhdGljIGlubGluZSBib29sIHBzY2lfcG93ZXJfc3RhdGVfbG9zZXNfY29udGV4dCh1MzIgc3Rh
dGUpCj4gIHsKPiAgCWNvbnN0IHUzMiBtYXNrID0gcHNjaV9oYXNfZXh0X3Bvd2VyX3N0YXRlKCkg
Pwo+IEBAIC02NTksMTAgKzY2NCwyNCBAQCBzdGF0aWMgaW50IF9faW5pdCBwc2NpXzBfMV9pbml0
KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApCj4gIAlyZXR1cm4gMDsKPiAgfQo+ICAKPiArc3RhdGlj
IGludCBfX2luaXQgcHNjaV8xXzBfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQo+ICt7Cj4g
KwlpbnQgZXJyOwo+ICsKPiArCWVyciA9IHBzY2lfMF8yX2luaXQobnApOwo+ICsJaWYgKGVycikK
PiArCQlyZXR1cm4gZXJyOwo+ICsKPiArCWlmIChwc2NpX2hhc19vc2lfc3VwcG9ydCgpKQo+ICsJ
CXByX2luZm8oIk9TSSBtb2RlIHN1cHBvcnRlZC5cbiIpOwo+ICsKPiArCXJldHVybiAwOwo+ICt9
Cj4gKwo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBwc2NpX29mX21hdGNoW10g
X19pbml0Y29uc3QgPSB7Cj4gIAl7IC5jb21wYXRpYmxlID0gImFybSxwc2NpIiwJLmRhdGEgPSBw
c2NpXzBfMV9pbml0fSwKPiAgCXsgLmNvbXBhdGlibGUgPSAiYXJtLHBzY2ktMC4yIiwJLmRhdGEg
PSBwc2NpXzBfMl9pbml0fSwKPiAtCXsgLmNvbXBhdGlibGUgPSAiYXJtLHBzY2ktMS4wIiwJLmRh
dGEgPSBwc2NpXzBfMl9pbml0fSwKPiArCXsgLmNvbXBhdGlibGUgPSAiYXJtLHBzY2ktMS4wIiwJ
LmRhdGEgPSBwc2NpXzFfMF9pbml0fSwKPiAgCXt9LAo+ICB9Owo+ICAKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L3BzY2kuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9wc2NpLmgKPiBp
bmRleCBiM2JjYWJlMzgwZGEuLjU4MWY3MjA4NWMzMyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvcHNjaS5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3BzY2kuaAo+IEBAIC00
OSw2ICs0OSw3IEBACj4gIAo+ICAjZGVmaW5lIFBTQ0lfMV8wX0ZOX1BTQ0lfRkVBVFVSRVMJCVBT
Q0lfMF8yX0ZOKDEwKQo+ICAjZGVmaW5lIFBTQ0lfMV8wX0ZOX1NZU1RFTV9TVVNQRU5ECQlQU0NJ
XzBfMl9GTigxNCkKPiArI2RlZmluZSBQU0NJXzFfMF9GTl9TRVRfU1VTUEVORF9NT0RFCQlQU0NJ
XzBfMl9GTigxNSkKPiAgCj4gICNkZWZpbmUgUFNDSV8xXzBfRk42NF9TWVNURU1fU1VTUEVORAkJ
UFNDSV8wXzJfRk42NCgxNCkKPiAgCj4gQEAgLTk3LDYgKzk4LDEwIEBACj4gICNkZWZpbmUgUFND
SV8xXzBfRkVBVFVSRVNfQ1BVX1NVU1BFTkRfUEZfTUFTSwlcCj4gIAkJCSgweDEgPDwgUFNDSV8x
XzBfRkVBVFVSRVNfQ1BVX1NVU1BFTkRfUEZfU0hJRlQpCj4gIAo+ICsjZGVmaW5lIFBTQ0lfMV8w
X09TX0lOSVRJQVRFRAkJCUJJVCgwKQo+ICsjZGVmaW5lIFBTQ0lfMV8wX1NVU1BFTkRfTU9ERV9Q
QwkJMAo+ICsjZGVmaW5lIFBTQ0lfMV8wX1NVU1BFTkRfTU9ERV9PU0kJCTEKPiArCj4gIC8qIFBT
Q0kgcmV0dXJuIHZhbHVlcyAoaW5jbHVzaXZlIG9mIGFsbCBQU0NJIHZlcnNpb25zKSAqLwo+ICAj
ZGVmaW5lIFBTQ0lfUkVUX1NVQ0NFU1MJCQkwCj4gICNkZWZpbmUgUFNDSV9SRVRfTk9UX1NVUFBP
UlRFRAkJCS0xCj4gCgoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDi
lIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0
dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3
aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcv
bGluYXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
