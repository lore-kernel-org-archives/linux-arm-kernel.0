Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87133C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:09:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CD32186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eWMSWwNR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAt5atSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CD32186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IcEnmH7u1r2UlWBBZ/uzrRDzk4w9nBzH4EMDT7hj6/o=; b=eWMSWwNRu3TiT1
	/+COWC2hT0GiyQ4GhL/36xw49K/RCo5Z1N1J+4eGaQTrGOpRlV82yJgKyaYOtjdHjxegtCo5mZXX0
	utGDSRMpbI/8qdsFJR/7/KDxQ9OcuPGgJSI4BxnM6dCs76oaV0a7fc7b2RrzITyWsHJ+855qDaQgc
	Iy0cbkRiI8zC9E7TbN1G3/vuY4pneNVEhcYNs5J0syIsSOALkXeChL+r1PuaOLcfVzkoS5B+Sfc8b
	lpP5HtIZEV2Bku4fS7zXd4ibklJlU0ZwIf5R7DZP+g+kffo6CevTZ021FOX4DVou52zG0jQaCrjYD
	uxVGjCHD+07zge1ieXBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZz0m-0006yE-3c; Thu, 20 Dec 2018 14:09:16 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZz0j-0006wU-AC
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 14:09:14 +0000
Received: by mail-wr1-x444.google.com with SMTP id r10so1897104wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 06:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MXCduRLidV5Y2s88Gyg/N4BgSVPqPJlaFtjfZoolwFI=;
 b=OAt5atSd5KMTOh+hCSw3lA8Vm1wj2zZPhIuXG3JC6DUfIw9JUEo+wUF0yRm4k6UKI1
 PwGV9lU1Sb4sdg1g2lK1AugYY5l+/UXO/+i1YCMMcRvcrGWVzEieae2kYF7tlGBmT6ZU
 q5XNVY9yCn0YyOyux//IJPou4zxCN9TDqwpJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MXCduRLidV5Y2s88Gyg/N4BgSVPqPJlaFtjfZoolwFI=;
 b=VQQx879WsXu+t/SNHcUMHL+77ZcVaJQvMjTL0fSSI9EwUK82WflmtXiOKReWiseoX/
 gF7xryn7G3P2ezhDsdCcD9qHUVBcLo7E23TqGBerEi1vQPVRR9l4eNiDMnSLmE8PUX5C
 43vy/j8ldFYpEt66XTyk72Kl15P4zBbaq4ws89Mkr5X0sVK94L95WMwfWA3RYNCvPCIK
 A6TSUhV9oAXTS96T+T6jxK1tUU2uUqG8LxxcXL8GuGbd4xcqJDp5lGYtPQKEQFJv5Zmf
 fFaFhZD7KpIaumWIcOTzaYdA9AlmUxJfuf/PNE5LHp75qLar6t+5I7x4uobn5egojo2S
 vyDg==
X-Gm-Message-State: AA+aEWZQzj0GKL/mTXadN0NR0qV/VZ34Slr48WL43Ua+tuDpXVeWO2mk
 JfgEDLXr5o9Su6+i7iatV+wOcg==
X-Google-Smtp-Source: AFSGD/W5+DNc3zSbSwCRnIPAvaohoz/ozEuusdKpfnYt1uD9X08g8RQESQ4F3STvJRH1ivydEeOojA==
X-Received: by 2002:adf:900f:: with SMTP id h15mr22696475wrh.18.1545314941239; 
 Thu, 20 Dec 2018 06:09:01 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
 by smtp.googlemail.com with ESMTPSA id c15sm1207011wml.27.2018.12.20.06.08.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 06:09:00 -0800 (PST)
Subject: Re: [PATCH v10 16/27] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla
 <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-17-ulf.hansson@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <20e1c04b-870f-3213-835d-28724ef4f530@linaro.org>
Date: Thu, 20 Dec 2018 15:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-17-ulf.hansson@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_060913_381199_7A33BB0B 
X-CRM114-Status: GOOD (  28.04  )
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

T24gMjkvMTEvMjAxOCAxODo0NiwgVWxmIEhhbnNzb24gd3JvdGU6Cj4gVG8gZW5hYmxlIHRoZSBP
UyBpbml0aWF0ZWQgbW9kZSwgdGhlIENQVSB0b3BvbG9neSBuZWVkcyB0byBiZSBkZXNjcmliZWQK
PiB1c2luZyB0aGUgaGllcmFyY2hpY2FsIG1vZGVsIGluIERULiBXaGVuIHVzZWQsIHRoZSBpZGxl
IHN0YXRlIGJpdHMgZm9yIHRoZQo+IENQVSBhcmUgY3JlYXRlZCBieSBPUmluZyB0aGUgYml0cyBm
b3IgUE0gZG9tYWluJ3MgaWRsZSBzdGF0ZS4KPiAKPiBMZXQncyBwcmVwYXJlIHRoZSBQU0NJIGRy
aXZlciB0byBkZWFsIHdpdGggdGhpcywgdmlhIGludHJvZHVjaW5nIGEgcGVyIENQVQo+IHZhcmlh
YmxlIGNhbGxlZCBkb21haW5fc3RhdGUgYW5kIGJ5IGFkZGluZyBpbnRlcm5hbCBoZWxwZXJzIHRv
IHJlYWQvd3JpdGUKPiB0aGUgdmFsdWUgb2YgdGhlIHZhcmlhYmxlLgoKV2hhdCBhcmUgdGhlIGRv
bWFpbiBzdGF0ZXMgPyBXaGF0IHZhbHVlcyBjYW4gdGhleSBoYXZlID8KCj4gQ2M6IExpbmEgSXll
ciA8aWxpbmFAY29kZWF1cm9yYS5vcmc+Cj4gQ28tZGV2ZWxvcGVkLWJ5OiBMaW5hIEl5ZXIgPGxp
bmEuaXllckBsaW5hcm8ub3JnPgo+IFNpZ25lZC1vZmYtYnk6IFVsZiBIYW5zc29uIDx1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnPgo+IC0tLQo+IAo+IENoYW5nZXMgaW4gdjEwOgo+IAktIFVzZSBfX3Ro
aXNfY3B1X3JlYWR8d3JpdGUoKSByYXRoZXIgdGhhbiB0aGlzX2NwdV9yZWFkfHdyaXRlKCkuCj4g
Cj4gLS0tCj4gIGRyaXZlcnMvZmlybXdhcmUvcHNjaS9wc2NpLmMgfCAyNiArKysrKysrKysrKysr
KysrKysrKysrLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYyBi
L2RyaXZlcnMvZmlybXdhcmUvcHNjaS9wc2NpLmMKPiBpbmRleCA0ZjBjYmM5NWU0MWIuLjhkYmNk
ZWNjMmFlNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5jCj4gKysr
IGIvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYwo+IEBAIC04Nyw4ICs4NywxOSBAQCBzdGF0
aWMgdTMyIHBzY2lfZnVuY3Rpb25faWRbUFNDSV9GTl9NQVhdOwo+ICAJCQkJKFBTQ0lfMV8wX0VY
VF9QT1dFUl9TVEFURV9JRF9NQVNLIHwgXAo+ICAJCQkJUFNDSV8xXzBfRVhUX1BPV0VSX1NUQVRF
X1RZUEVfTUFTSykKPiAgCj4gK3N0YXRpYyBERUZJTkVfUEVSX0NQVSh1MzIsIGRvbWFpbl9zdGF0
ZSk7Cj4gIHN0YXRpYyB1MzIgcHNjaV9jcHVfc3VzcGVuZF9mZWF0dXJlOwo+ICAKPiArc3RhdGlj
IGlubGluZSB1MzIgcHNjaV9nZXRfZG9tYWluX3N0YXRlKHZvaWQpCj4gK3sKPiArCXJldHVybiBf
X3RoaXNfY3B1X3JlYWQoZG9tYWluX3N0YXRlKTsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSB2
b2lkIHBzY2lfc2V0X2RvbWFpbl9zdGF0ZSh1MzIgc3RhdGUpCj4gK3sKPiArCV9fdGhpc19jcHVf
d3JpdGUoZG9tYWluX3N0YXRlLCBzdGF0ZSk7Cj4gK30KPiArCj4gIHN0YXRpYyBpbmxpbmUgYm9v
bCBwc2NpX2hhc19leHRfcG93ZXJfc3RhdGUodm9pZCkKPiAgewo+ICAJcmV0dXJuIHBzY2lfY3B1
X3N1c3BlbmRfZmVhdHVyZSAmCj4gQEAgLTE4Nyw2ICsxOTgsOCBAQCBzdGF0aWMgaW50IHBzY2lf
Y3B1X29uKHVuc2lnbmVkIGxvbmcgY3B1aWQsIHVuc2lnbmVkIGxvbmcgZW50cnlfcG9pbnQpCj4g
IAo+ICAJZm4gPSBwc2NpX2Z1bmN0aW9uX2lkW1BTQ0lfRk5fQ1BVX09OXTsKPiAgCWVyciA9IGlu
dm9rZV9wc2NpX2ZuKGZuLCBjcHVpZCwgZW50cnlfcG9pbnQsIDApOwo+ICsJLyogQ2xlYXIgdGhl
IGRvbWFpbiBzdGF0ZSB0byBzdGFydCBmcmVzaC4gKi8KPiArCXBzY2lfc2V0X2RvbWFpbl9zdGF0
ZSgwKTsKPiAgCXJldHVybiBwc2NpX3RvX2xpbnV4X2Vycm5vKGVycik7CgpJIHRoaW5rIHRoaXMg
Y2hhbmdlIGlzIGFtYmlndW91czoKCiAtIGlmIGl0IGlzIGEgY2hhbmdlIG9mIHRoZSBzdGF0ZSBi
ZWNhdXNlIG9mIHRoZSBjcHVfb24sIHRoZW4gSSB3YXMKZXhwZWN0aW5nIGEgc2ltaWxhciBjaGFu
Z2UgaW4gY3B1X29mZiBhbmQgdGhlIGNoYW5nZSBvbmx5IGlmCmludm9rZV9wc2NpX2ZuKCkgc3Vj
Y2VlZHMuCgogLSBpZiBpdCBpcyBhIGNoYW5nZSB0byB0YWtlIG9wcG9ydHVuaXR5IG9mIHRoZSBj
b2RlIHBhdGggdG8gaW5pdGlhbGl6ZQp0aGUgZG9tYWluIHN0YXRlLCBJIHN1Z2dlc3QgdG8gcmVt
b3ZlIGl0IGZyb20gdGhlcmUgYW5kIG1ha2UgaXQgdmVyeQpleHBsaWNpdCB3aXRoIHN0YXRpYyBE
RUZJTkVfUEVSX0NQVSh1MzIsIGRvbWFpbl9zdGF0ZSkgPSB7IDAgfTsKCgo+ICB9Cj4gIAo+IEBA
IC00MDksMTUgKzQyMiwxNyBAQCBpbnQgcHNjaV9jcHVfaW5pdF9pZGxlKHN0cnVjdCBjcHVpZGxl
X2RyaXZlciAqZHJ2LCB1bnNpZ25lZCBpbnQgY3B1KQo+ICBzdGF0aWMgaW50IHBzY2lfc3VzcGVu
ZF9maW5pc2hlcih1bnNpZ25lZCBsb25nIGluZGV4KQo+ICB7Cj4gIAl1MzIgKnN0YXRlID0gX190
aGlzX2NwdV9yZWFkKHBzY2lfcG93ZXJfc3RhdGUpOwo+ICsJdTMyIGNvbXBvc2l0ZV9zdGF0ZSA9
IHN0YXRlW2luZGV4IC0gMV0gfCBwc2NpX2dldF9kb21haW5fc3RhdGUoKTsKPiAgCj4gLQlyZXR1
cm4gcHNjaV9vcHMuY3B1X3N1c3BlbmQoc3RhdGVbaW5kZXggLSAxXSwKPiAtCQkJCSAgICBfX3Bh
X3N5bWJvbChjcHVfcmVzdW1lKSk7Cj4gKwlyZXR1cm4gcHNjaV9vcHMuY3B1X3N1c3BlbmQoY29t
cG9zaXRlX3N0YXRlLCBfX3BhX3N5bWJvbChjcHVfcmVzdW1lKSk7Cj4gIH0KPiAgCj4gIGludCBw
c2NpX2NwdV9zdXNwZW5kX2VudGVyKHVuc2lnbmVkIGxvbmcgaW5kZXgpCj4gIHsKPiAgCWludCBy
ZXQ7Cj4gIAl1MzIgKnN0YXRlID0gX190aGlzX2NwdV9yZWFkKHBzY2lfcG93ZXJfc3RhdGUpOwo+
ICsJdTMyIGNvbXBvc2l0ZV9zdGF0ZSA9IHN0YXRlW2luZGV4IC0gMV0gfCBwc2NpX2dldF9kb21h
aW5fc3RhdGUoKTsKPiArCj4gIAkvKgo+ICAJICogaWRsZSBzdGF0ZSBpbmRleCAwIGNvcnJlc3Bv
bmRzIHRvIHdmaSwgc2hvdWxkIG5ldmVyIGJlIGNhbGxlZAo+ICAJICogZnJvbSB0aGUgY3B1X3N1
c3BlbmQgb3BlcmF0aW9ucwo+IEBAIC00MjUsMTEgKzQ0MCwxNCBAQCBpbnQgcHNjaV9jcHVfc3Vz
cGVuZF9lbnRlcih1bnNpZ25lZCBsb25nIGluZGV4KQo+ICAJaWYgKFdBUk5fT05fT05DRSghaW5k
ZXgpKQo+ICAJCXJldHVybiAtRUlOVkFMOwo+ICAKPiAtCWlmICghcHNjaV9wb3dlcl9zdGF0ZV9s
b3Nlc19jb250ZXh0KHN0YXRlW2luZGV4IC0gMV0pKQo+IC0JCXJldCA9IHBzY2lfb3BzLmNwdV9z
dXNwZW5kKHN0YXRlW2luZGV4IC0gMV0sIDApOwo+ICsJaWYgKCFwc2NpX3Bvd2VyX3N0YXRlX2xv
c2VzX2NvbnRleHQoY29tcG9zaXRlX3N0YXRlKSkKPiArCQlyZXQgPSBwc2NpX29wcy5jcHVfc3Vz
cGVuZChjb21wb3NpdGVfc3RhdGUsIDApOwo+ICAJZWxzZQo+ICAJCXJldCA9IGNwdV9zdXNwZW5k
KGluZGV4LCBwc2NpX3N1c3BlbmRfZmluaXNoZXIpOwo+ICAKPiArCS8qIENsZWFyIHRoZSBkb21h
aW4gc3RhdGUgdG8gc3RhcnQgZnJlc2ggd2hlbiBiYWNrIGZyb20gaWRsZS4gKi8KPiArCXBzY2lf
c2V0X2RvbWFpbl9zdGF0ZSgwKTsKPiArCj4gIAlyZXR1cm4gcmV0Owo+ICB9Cj4gIAo+IAoKCi0t
IAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNv
ZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29r
LmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5h
cm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxv
ZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
