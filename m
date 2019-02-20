Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2B8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:30:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E144720C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rYk61NLb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaUSPDt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E144720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ts8QmF7fRz6EOM6albK9lu6nDV7ZtHnfN9aK+B23RzI=; b=rYk61NLbdyFXbc
	7HWJJ1rDmIk4jy/PrcEVmhh3HmGhCUpShHG47HsdIqP5KpcuH3eMaGzTzZACrMVdwewTxfP11jSOP
	Lm0nrJ4DXbmRoL4gNVaZTu0a4rT7jfZCjC33B2FMU1ydTW+iBRNFUts+ALJklk/SPfGaUXPSRSW96
	XpPuCeLl56nseXHFkv4503BYuzR0J+vRHiimOiAn/KVAz6eip9pwAYixCiuojRxnRHCNX111XI5Cp
	k7jbKZqPcizJewpiP/CkEU5d40B+Mjzzo250OXkEs6yVyOP0u/+aj9MGVCTFghcFWxMdYcGM5Il3G
	7kMWPoVKI2Tl+QPXvkyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwRxL-0007Fr-FS; Wed, 20 Feb 2019 13:30:35 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwRxI-0007EU-Fn
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:30:33 +0000
Received: by mail-pl1-x642.google.com with SMTP id m10so2575051plt.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 05:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qy04mKzoL16kaKUgEkcr5rBVmxccfjZptBeFKXDuxX4=;
 b=UaUSPDt+CASC9nvRx3/L8wM8jaGF3+vSR1u9JOLeXeISX4poVGcXMA4pU6hpQHIGoG
 eeVDfM0G1r06KcRHYQpz9Cq23JiXyOfGeis+/mRiKwxUmIEURCrDWGqzzBVLJy+jBAyg
 h0SzKCCkUx/1zgPV5ZWEIDiwp2ZGpqxo0Eoy1/+y0xcTV8gfhYUxvpWX2mpZGa3937bB
 0E7jA2MBqQ6blq6lxUI+uvS30Q36ze6Mn050xeqF6uMhdwvvdaYMHmKThgCu66DU/wXI
 XERLT+A/+qPq8bp4JiSHUxlDiX8cbPvYunnNJGQdJd2AhcWXxChuyqlav8plB7tLjfaj
 otXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qy04mKzoL16kaKUgEkcr5rBVmxccfjZptBeFKXDuxX4=;
 b=tZ+Rl5rLNoiZX0KO3v+1u7kiYkU6B/BXk1t9pLUilQq0t7Tbub0v77c3wMMxeUouzs
 CZtvIyWq5oKL6ufQkOm+0VDLd3JlswgugI2QKek0txwGzTvw/8p7xyEQiUATAMjuKaib
 E4LwaR2iErqGhOPN6spHkzp3vYIhSqCjeHNIzGQ/PmxJPnPibYopF46v4NahkEObgUfq
 IiVcK7dWsKAUQ22C2pCp1DuzDRrSLFGYr4T1+OMrOV7JdZeRFmlCMrx4MO3wVqmX1uxQ
 ZJ3hnJqVADu+zL4RKJtzUWWECWiepQdHSdDvDwY5IOEsKYdnqJcsP2aQwlCFbyYzPhiV
 ijSQ==
X-Gm-Message-State: AHQUAuamioD/FCTgciQYKdLF+lCXYirkL42VFWBzG3XD/Li1AJJbBded
 4jhMy/iR3/7eBmSIUxkIH1s=
X-Google-Smtp-Source: AHgI3IZj3eHY4pAV2P5YuTvM/dcJBqwavtz+ELmWQVqm0o+LMl5vt/kCbCYoevuFuZLpN/veR/vTfw==
X-Received: by 2002:a17:902:e90b:: with SMTP id
 cs11mr14674338plb.197.1550669430801; 
 Wed, 20 Feb 2019 05:30:30 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.googlemail.com with ESMTPSA id h3sm4447539pgv.38.2019.02.20.05.30.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 05:30:29 -0800 (PST)
Subject: Re: [PATCH v4 0/8] Support Trusted Foundations firmware on Tegra30
From: Dmitry Osipenko <digetx@gmail.com>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20190218001726.16785-1-digetx@gmail.com>
Message-ID: <c6d761cf-370c-c4f7-931b-d2333e02f2dc@gmail.com>
Date: Wed, 20 Feb 2019 16:30:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_053032_549789_934755BB 
X-CRM114-Status: GOOD (  11.19  )
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
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Robert Yang <decatf@gmail.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MTguMDIuMjAxOSAzOjE3LCBEbWl0cnkgT3NpcGVua28g0L/QuNGI0LXRgjoKPiBIZWxsbywKPiAK
PiBUaGlzIHBhdGNoc2V0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIFRydXN0ZWQgRm91bmRhdGlvbnMg
ZmlybXdhcmUgb24KPiBOVklESUEgVGVncmEzMC4gUHJldHR5IG11Y2ggYWxsIG9mIFRlZ3JhMzAg
Y29uc3VtZXIgZGV2aWNlcyBoYXZlIHRoYXQKPiBmaXJtd2FyZSBhbmQgdXBzdHJlYW0ga2VybmVs
IGNhbid0IGJvb3Qgb24gdGhvc2UgZGV2aWNlcyB3aXRob3V0IHRoZQo+IGZpcm13YXJlIHN1cHBv
cnQuCgpIZWxsbyBNaWNoYcWCLAoKV2lsbCBiZSBhd2Vzb21lIGlmIHlvdSBjb3VsZCB0ZXN0IHRo
ZSBzZXJpZXMgb24geW91cnMgVEYzMDBUIGFuZCByZXBvcnQgYmFjaywgdGhhbmtzIGluIGFkdmFu
Y2UhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
