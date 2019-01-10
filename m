Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E9DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:55:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CA820685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jMC1v5mn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RraR06AC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CA820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dkhbI0WiQa0VHzJuum/W5MTa2APpuscnDzIN42L31RY=; b=jMC1v5mn/ikj9r
	bv1NSh85It4TehHDE+zHOHic/zsmOmkO/BpbMdX9Wore4fTHv2aA53vZUiG6luiQf4r2A2bkfrA+l
	gatr2H6gzQTDrczC7hTp6mdEkdd4jRAIHHVucCYTnAoLsa/gyZhEfzoLHc6mVrrGFUbwXERvIgF1d
	u25ClSBzRuU6kYmoL2GQ9gp3IB5tsaRMePjCk2PlDi4rrDcYe7jhzmjcLuM0FAPLhMTFo5KQVD7Do
	4FTxlncvxmKp2z4s6TCM8ZFWQY8mahE7n3wS0IjL4VwdiFQT/H5Ay4AaPRB10o+tBitdM8f5Li3tk
	ThdEkgHVUhrcHnjUR6jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghVBr-0004xR-AB; Thu, 10 Jan 2019 07:55:47 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghVBn-0004ww-HB
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:55:44 +0000
Received: by mail-it1-x141.google.com with SMTP id c9so14968509itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 23:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Yov8D8gjWhHIk/2X+MdgDF7F0r4fp0ReXoEM3MeFAxY=;
 b=RraR06AC/7qgLypkw/Kx5hZk6MdG1ggq119b/mzHf3G9LY+Lh8sakgHAbX8UNvUmPf
 Ir+J2Dz/DE/3q0jXGQB3vzOO8S2AaaFwrH9dfnn7CkAMh+vRyty+C6omAuqFf9G+J2kc
 Xi5rpx2l2htLjRFJggx27Yk24NAdUN+iO1tes9PpwDhcYqQBxSj9mhSnZGtnbWdbK/cB
 VNJHJXJnJe642jAPgXiwqmY4/LkuUFkx1xzpu2qfvdISNaQ4pB7Tvw6+ufbYWlgpXz1o
 XZA21Zl8lx+YTF8p4prtV2qIc7ztaq7NRO7P3ZJiPv14Ni0foxGoRfZEkFnQdfl/fGgQ
 HKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Yov8D8gjWhHIk/2X+MdgDF7F0r4fp0ReXoEM3MeFAxY=;
 b=P0wrMBRd9HbQBRkyN2MqvgEu644R0lo4uzwLsEtyedXxHodSG4Tn1xrhjczg04IWa2
 AxPoRrOXwwzr0I1KF8L76KlqLqZty0v0rCPJ088oLjoaU59VTbT9zs15GVI1VUy75bec
 ac4JPce2tIRIceKwFknj8gEOPCNcLiVrMNchk7N7MFGnrFm6LS9+H/2ziuWtPSPlZ6FN
 Cag1dYDTvZN6WvX4asJNGskKoboGs0oX+rMC7zT2s60Hi5gul3JJb+6U5gIXaURYQgIE
 P8DGC2OusTYUSyF5vrtMVFz4w3F46yNCJ3ivP4hAnDZEn4Tszb7iwSBYMRyuiWGAoYGL
 ElCg==
X-Gm-Message-State: AJcUukepleKUjQgDoGLiMRJQEKKgtoDnQ5om4b6xYW7QfqfP1ujguZpZ
 hiEfUiZhRJpkYxiMsrcXg97lCjez5INUBBvpStk=
X-Google-Smtp-Source: ALg8bN6BdBASQyZr3JOAize8EhSV0zHdzwrPhboERUcM1OXmPnmxdRZINyRfeHSyYAh23sghjlFH/HHPy8y8horEIjc=
X-Received: by 2002:a24:b34f:: with SMTP id z15mr6062922iti.61.1547106942285; 
 Wed, 09 Jan 2019 23:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com>
 <20190110070208.lvnrcd2nld3zthmk@vireshk-i7>
In-Reply-To: <20190110070208.lvnrcd2nld3zthmk@vireshk-i7>
From: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Date: Thu, 10 Jan 2019 08:55:31 +0100
Message-ID: <CAKpie0TvS4bzdv82m8T24GaH_DrGsjdznCSQcugtt9DqKss_sg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: defconfig: s5pv210: Add cpufreq support
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_235543_601225_B0F31ACE 
X-CRM114-Status: GOOD (  13.82  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 "moderated list:SAMSUNG SOC CLOCK DRIVERS"
 <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org,
 rjw@rjwysocki.net, linux@armlinux.org.uk,
 Krzysztof Kozlowski <krzk@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Y3p3LiwgMTAgc3R5IDIwMTkgbyAwODowMiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5h
cm8ub3JnPiBuYXBpc2HFgihhKToKPgo+IE9uIDA4LTAxLTE5LCAyMTowNSwgUGF3ZcWCIENobWll
bCB3cm90ZToKPiA+IFRoaXMgY29tbWl0IGVuYWJsZXMgY3B1ZnJlcSBzdXBwb3J0IGZvciBhbGwg
czVwdjIxMCBkZXZpY2VzLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBh
d2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gIGFyY2gvYXJtL2NvbmZp
Z3MvczVwdjIxMF9kZWZjb25maWcgfCA2ICsrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vY29uZmlncy9zNXB2MjEw
X2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9kZWZjb25maWcKPiA+IGluZGV4
IDk1MTE5NmJkZjAwOC4uZmQ0ZjI4YWFiZGE2IDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm0vY29u
Zmlncy9zNXB2MjEwX2RlZmNvbmZpZwo+ID4gKysrIGIvYXJjaC9hcm0vY29uZmlncy9zNXB2MjEw
X2RlZmNvbmZpZwo+ID4gQEAgLTExLDYgKzExLDEyIEBAIENPTkZJR19BUkNIX1M1UFYyMTA9eQo+
ID4gIENPTkZJR19WTVNQTElUXzJHPXkKPiA+ICBDT05GSUdfQVJNX0FQUEVOREVEX0RUQj15Cj4g
PiAgQ09ORklHX0NNRExJTkU9InJvb3Q9L2Rldi9yYW0wIHJ3IHJhbWRpc2s9ODE5MiBpbml0cmQ9
MHgyMDgwMDAwMCw4TSBjb25zb2xlPXR0eVNBQzEsMTE1MjAwIGluaXQ9L2xpbnV4cmMiCj4gPiAr
Q09ORklHX0NQVV9GUkVRPXkKPiA+ICtDT05GSUdfQ1BVX0ZSRVFfU1RBVD15Cj4gPiArQ09ORklH
X0NQVV9GUkVRX0RFRkFVTFRfR09WX09OREVNQU5EPXkKPiA+ICtDT05GSUdfQ1BVX0ZSRVFfR09W
X1BPV0VSU0FWRT1tCj4gPiArQ09ORklHX0NQVV9GUkVRX0dPVl9VU0VSU1BBQ0U9bQo+ID4gK0NP
TkZJR19DUFVfRlJFUV9HT1ZfQ09OU0VSVkFUSVZFPW0KPgo+IFlvdSBkb24ndCB3YW50IHRvIHVz
ZSBzY2hlZHV0aWwgPyBUaGF0IGlzIHRoZSBkZWZhdWx0IGdvdmVybm9yIGZvcgo+IGV2ZXJ5b25l
IG5vdyBhIGRheXMuCnNjaGVkdXRpbCBkZXBlbmRzIG9uIFNNUCwgd2hpY2ggaXMgbm90IGVuYWJs
ZWQgb24gczVwdjIxMCAoaXQgaGFzIG9ubHkKb25lIGNwdSBjb3JlKS4KPgo+IC0tCj4gdmlyZXNo
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
