Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2273DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:09:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAF32184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CcgLRd5j";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHt6qhdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAF32184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oHFolYdSymc/Xv7c4LmzW39w8tgNfjisGUtmLUq81u8=; b=CcgLRd5jY8YGo5
	HK+qk3yVfzfs5WLjJuehaN8IA78rZ7vQ2UUDpHhPEJXDfr2ZX+TSuSM5adMd5DZtF3fBzC+yhaU7I
	k2yxGEFkXM7Mm38Z4Gh9ftHMDLBuXbiPWT5aJjKV235nfFrN5veVZOv17hd6XLg/cg+ohOtwKms6J
	IpVIchfghPeeIRRDu0xAQEf6omWsSZX8R0+WvD8W86uSnbGlTA5sf+87pYMnTQURURkY1mJ/Ev4+U
	f2TNdvkUE+ECaiXD3qF8NACVYHuv/l9ZdYcGgTg9uKqzVikAC+fNUFR5WWEIKbM7h03453SF21cXE
	HHIdAMkLj1cymXSjyq7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZaen-0001oK-Dr; Wed, 19 Dec 2018 12:08:57 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZaek-0001nA-3a
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 12:08:55 +0000
Received: by mail-wr1-x441.google.com with SMTP id s12so18842549wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 04:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IaqOoapHzjoMgO9YBbjQ3EZTwNanLJVjZn5hJwj2FMk=;
 b=GHt6qhdGISkevDdYgX9XDmZqTUrpsOtUkVOBKIbGbZmHTLRgl/a+k11cej4RUqVO3/
 ftHAHNyASYjk3Cd+UVAXnV/gXUqm/+ebm8lFCLivPHR6828aha3qN+KY1Bac208b8d6I
 vW4h4x4r6Fik7GSpklOsMsRdqoFGTvmty9v2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IaqOoapHzjoMgO9YBbjQ3EZTwNanLJVjZn5hJwj2FMk=;
 b=E6K7y2RZeulN4Zau6XcZ3cJ/kfxHNgDBg1EqF3ACRYAFdoUhvVVgzmOxkiYkWOBmi4
 QmNQbJgGAcQZaTahbNK7rs66p4HK/6ubIgBiqZkR0Hyw6A0G+6Oczqio0wWPW1HlrllF
 BF4ed3UaUEc16EUpij3aM+m2RrshNeXTcDIVlxPcIyzjZe8GxSQBbWNfv+xod7kv9nWy
 AqMC0RoER38iWsKCidVC//xIELqw5TOCkTJrziE/bRclwRY3LWhNyI9F7Y6Wft0lPs1t
 9G42A6IfyBjzO7kbe0/4WRIz53MoqtGhG2Vmd7B0WzwZHZijG59q8vn6pQVWpuF8uzVk
 xCng==
X-Gm-Message-State: AA+aEWbv+byivpf6PDjNDySZOlO4fZwwV1ujE1YdENX6P++3xSqn6lWt
 fzZJNT3Z8cbOFyEzQAcIXlVQ1w==
X-Google-Smtp-Source: AFSGD/W57nD1tL27pfIe1rKnlQoQOhHACPw0m7wioQ4cwubuZPACAukH4mCrqnxpy06Gle4OvJUPBg==
X-Received: by 2002:adf:8143:: with SMTP id 61mr17875097wrm.47.1545221322006; 
 Wed, 19 Dec 2018 04:08:42 -0800 (PST)
Received: from [192.168.0.40] (197.26.136.77.rev.sfr.net. [77.136.26.197])
 by smtp.googlemail.com with ESMTPSA id
 e142sm12036003wmf.46.2018.12.19.04.08.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 04:08:41 -0800 (PST)
Subject: Re: [PATCH v10 14/27] drivers: firmware: psci: Simplify error path of
 psci_dt_init()
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla
 <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-15-ulf.hansson@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e5218407-f08b-9eda-9a67-0acea0e04e6e@linaro.org>
Date: Wed, 19 Dec 2018 13:08:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-15-ulf.hansson@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_040854_151838_4E6EB15C 
X-CRM114-Status: GOOD (  21.89  )
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

T24gMjkvMTEvMjAxOCAxODo0NiwgVWxmIEhhbnNzb24gd3JvdGU6Cj4gSW5zdGVhZCBvZiBoYXZp
bmcgZWFjaCBwc2NpIGluaXQgZnVuY3Rpb24gdGFraW5nIGNhcmUgb2YgdGhlIG9mX25vZGVfcHV0
KCksCj4gbGV0J3MgZGVhbCB3aXRoIHRoYXQgZnJvbSBwc2NpX2R0X2luaXQoKSwgYXMgdGhpcyBl
bmFibGVzIGEgYml0IHNpbXBsZXIKPiBlcnJvciBwYXRoIGZvciBlYWNoIHBzY2kgaW5pdCBmdW5j
dGlvbi4KPiAKPiBDYzogTGluYSBJeWVyIDxpbGluYUBjb2RlYXVyb3JhLm9yZz4KPiBDby1kZXZl
bG9wZWQtYnk6IExpbmEgSXllciA8bGluYS5peWVyQGxpbmFyby5vcmc+Cj4gU2lnbmVkLW9mZi1i
eTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+Cj4gQWNrZWQtYnk6IE1hcmsg
UnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+CgpSZXZpZXdlZC1ieTogRGFuaWVsIExlemNh
bm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+CgoKPiAtLS0KPiAKPiBDaGFuZ2VzIGluIHYx
MDoKPiAJLSBOb25lLgo+IAo+IC0tLQo+ICBkcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5jIHwg
MjMgKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDEzIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJl
L3BzY2kvcHNjaS5jIGIvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYwo+IGluZGV4IDYzMWUy
MDcyMGEyMi4uNmJmYTQ3Y2JkMTc0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvcHNj
aS9wc2NpLmMKPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5jCj4gQEAgLTYwOSw5
ICs2MDksOSBAQCBzdGF0aWMgaW50IF9faW5pdCBwc2NpXzBfMl9pbml0KHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnApCj4gIAlpbnQgZXJyOwo+ICAKPiAgCWVyciA9IGdldF9zZXRfY29uZHVpdF9tZXRo
b2QobnApOwo+IC0KPiAgCWlmIChlcnIpCj4gLQkJZ290byBvdXRfcHV0X25vZGU7Cj4gKwkJcmV0
dXJuIGVycjsKPiArCj4gIAkvKgo+ICAJICogU3RhcnRpbmcgd2l0aCB2MC4yLCB0aGUgUFNDSSBz
cGVjaWZpY2F0aW9uIGludHJvZHVjZWQgYSBjYWxsCj4gIAkgKiAoUFNDSV9WRVJTSU9OKSB0aGF0
IGFsbG93cyBwcm9iaW5nIHRoZSBmaXJtd2FyZSB2ZXJzaW9uLCBzbwo+IEBAIC02MTksMTEgKzYx
OSw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHBzY2lfMF8yX2luaXQoc3RydWN0IGRldmljZV9ub2Rl
ICpucCkKPiAgCSAqIGNhbiBiZSBjYXJyaWVkIG91dCBhY2NvcmRpbmcgdG8gdGhlIHNwZWNpZmlj
IHZlcnNpb24gcmVwb3J0ZWQKPiAgCSAqIGJ5IGZpcm13YXJlCj4gIAkgKi8KPiAtCWVyciA9IHBz
Y2lfcHJvYmUoKTsKPiAtCj4gLW91dF9wdXRfbm9kZToKPiAtCW9mX25vZGVfcHV0KG5wKTsKPiAt
CXJldHVybiBlcnI7Cj4gKwlyZXR1cm4gcHNjaV9wcm9iZSgpOwo+ICB9Cj4gIAo+ICAvKgo+IEBA
IC02MzUsOSArNjMxLDggQEAgc3RhdGljIGludCBfX2luaXQgcHNjaV8wXzFfaW5pdChzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wKQo+ICAJaW50IGVycjsKPiAgCj4gIAllcnIgPSBnZXRfc2V0X2NvbmR1
aXRfbWV0aG9kKG5wKTsKPiAtCj4gIAlpZiAoZXJyKQo+IC0JCWdvdG8gb3V0X3B1dF9ub2RlOwo+
ICsJCXJldHVybiBlcnI7Cj4gIAo+ICAJcHJfaW5mbygiVXNpbmcgUFNDSSB2MC4xIEZ1bmN0aW9u
IElEcyBmcm9tIERUXG4iKTsKPiAgCj4gQEAgLTY2MSw5ICs2NTYsNyBAQCBzdGF0aWMgaW50IF9f
aW5pdCBwc2NpXzBfMV9pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApCj4gIAkJcHNjaV9vcHMu
bWlncmF0ZSA9IHBzY2lfbWlncmF0ZTsKPiAgCX0KPiAgCj4gLW91dF9wdXRfbm9kZToKPiAtCW9m
X25vZGVfcHV0KG5wKTsKPiAtCXJldHVybiBlcnI7Cj4gKwlyZXR1cm4gMDsKPiAgfQo+ICAKPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgcHNjaV9vZl9tYXRjaFtdIF9faW5pdGNv
bnN0ID0gewo+IEBAIC02NzgsNiArNjcxLDcgQEAgaW50IF9faW5pdCBwc2NpX2R0X2luaXQodm9p
ZCkKPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7Cj4gIAljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkICptYXRjaGVkX25wOwo+ICAJcHNjaV9pbml0Y2FsbF90IGluaXRfZm47Cj4gKwlpbnQgcmV0
Owo+ICAKPiAgCW5wID0gb2ZfZmluZF9tYXRjaGluZ19ub2RlX2FuZF9tYXRjaChOVUxMLCBwc2Np
X29mX21hdGNoLCAmbWF0Y2hlZF9ucCk7Cj4gIAo+IEBAIC02ODUsNyArNjc5LDEwIEBAIGludCBf
X2luaXQgcHNjaV9kdF9pbml0KHZvaWQpCj4gIAkJcmV0dXJuIC1FTk9ERVY7Cj4gIAo+ICAJaW5p
dF9mbiA9IChwc2NpX2luaXRjYWxsX3QpbWF0Y2hlZF9ucC0+ZGF0YTsKPiAtCXJldHVybiBpbml0
X2ZuKG5wKTsKPiArCXJldCA9IGluaXRfZm4obnApOwo+ICsKPiArCW9mX25vZGVfcHV0KG5wKTsK
PiArCXJldHVybiByZXQ7Cj4gIH0KPiAgCj4gICNpZmRlZiBDT05GSUdfQUNQSQo+IAoKCi0tIAog
PGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3
YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNv
bS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9v
cmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
