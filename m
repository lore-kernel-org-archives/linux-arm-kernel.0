Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE034C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:44:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8012229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FiCrr2Su";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUjdRgAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8012229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=auXSA0kKux7SPxrKlP3M3TOG5MnnoaT2g+Ns+cEqFbk=; b=FiCrr2Suoo+978
	MjTG3dywgweZIkWggDgwZKLdmyTaCzM9wECEfgczvTjvvjiMnrTkmrXexFnk9ZNjGqaLp39XrN6gk
	37TZo3mcdn30Sl5RqpnVtc2jC4HjhB6D5oDasGbyON8ECj/93+DdJ1eA3Ozz+H6quaPsSZjXRmf1s
	atV7y6Z3TbZqe3Ds6rRLqEAQtikp4/r6dkY6Sn3hAnzNKqj8O01SFOLw/aeHFTobUHbm34Q7yYmT/
	GY7QEWUVHjMHaXrt+taHgGrns80zbLXL1du/g+KsLgO7U2kZ4WH8D3vidAsIukmfHRyvIdLvcGmRm
	3Vqo5ZMfp1cCvC7A783A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIFT-0000KP-ES; Thu, 14 Feb 2019 14:44:23 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIFP-0000Jd-5X
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:44:20 +0000
Received: by mail-wm1-x343.google.com with SMTP id v26so6353392wmh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OElgaH9/rySIbebd8tZ+DsfKLXEMJFPUAht1tqtT8kc=;
 b=YUjdRgADxK0ZPbTAvp/LTfJPXhOz+Jk+KHaRlC64g+nV1uwnoMFmqiDuFB4sis17zb
 UfuOsuvLdlVMG1HpLucv906FNBl5p7mevu6kksDwOyPNq4tZOq9Xumrt5ewfgRy0FRgK
 FeuCG2YlyR+93O7h6lb2231kdpK0zFCN/PN0PvGsTqNLKwWwL0D7lSFr2pCkXPYpU0By
 /TFTcnWSHC0lseH1hs9C5f6PFJ3Cr3NqPpmK006x3QOfOlIy+f34RgoWQAf44OUn0T/W
 +B3Ra4t+hFV+x0Vc31L1gGdG9i18H9lyoQFu9l+LM0q+Lh4biTAn1KqLGf+9RN9o9ZWW
 GaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OElgaH9/rySIbebd8tZ+DsfKLXEMJFPUAht1tqtT8kc=;
 b=HpC+TmkIALiLOCPwBCHqczSxfAM+FzRNWJnvJpujShVxgXGH6jFQBRbXm3TN+gXMKJ
 Kj6RHLNdIqx15o/xSP8+qmaKrLqxNbiOCBOdWFIe1rzx/AHAm8d24S2kgoPMbIGsaoEJ
 2djLmnQnHrpD/t/Pz/nf1XmHplXLJl2TSIoHBcTMSTTc6EYPp5aQJCpUAXGxLg89TTfX
 N02vDL8/eX3QdUx04J2O/gxGtNXu6e0nycwUVLj13ZZV15S9JiuXki+gBfdSO1Le/v0o
 sVqFndX/1+MWXFZh0+//DXx6KSVc5OgDnNiyj5++WDiYeguLb5VfYIgayGL4FdwaZNy1
 zd2Q==
X-Gm-Message-State: AHQUAuZ6HQh7ie+EaEkYbtLyLa0x5bffoCXnA4fwGbGwPOyVGf+A6S6U
 cGiLV0KjhPgT4IyoAapVip+sdg==
X-Google-Smtp-Source: AHgI3Ialsr+3wy2S2VJYKZwI6YIPfJNVQpNR5htc5iXDao/0SZKdxuce12XstXxKpSaNYhUEOmv6SA==
X-Received: by 2002:a1c:47:: with SMTP id 68mr2858553wma.89.1550155456046;
 Thu, 14 Feb 2019 06:44:16 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id e7sm3913430wrw.35.2019.02.14.06.44.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:44:15 -0800 (PST)
Subject: Re: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
To: "Sugaya, Taichi" <sugaya.taichi@socionext.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnd Bergmann <arnd.bergmann@linaro.org>
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
 <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org>
 <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
Date: Thu, 14 Feb 2019 15:44:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_064419_214157_3500CF67 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Takao Orito <orito.takao@socionext.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-soc@vger.kernel.org, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTMvMDIvMjAxOSAxMTozNCwgU3VnYXlhLCBUYWljaGkgd3JvdGU6Cj4gSGksCj4gCj4gT24g
MjAxOS8wMi8xMiAxODowNiwgRGFuaWVsIExlemNhbm8gd3JvdGU6Cj4+IE9uIDA4LzAyLzIwMTkg
MTM6MjYsIFN1Z2F5YSBUYWljaGkgd3JvdGU6Cj4+PiBBZGQgdGltZXIgZHJpdmVyIGZvciBNaWxi
ZWF1dCBTb0NzIHNlcmllcy4KPj4+Cj4+PiBUaGUgdGltZXIgaGFzIHR3byAzMi1iaXQgd2lkdGgg
ZG93biBjb3VudGVycywgb25lIG9mIHdoaWNoIGlzIGNvbmZpZ3VyZWQKPj4+IGFzIGEgY2xvY2tl
dmVudCBkZXZpY2UgYW5kIHRoZSBvdGhlciBpcyBjb25maWd1cmVkIGFzIGEgY2xvY2sgc291cmNl
Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFN1Z2F5YSBUYWljaGkgPHN1Z2F5YS50YWljaGlAc29j
aW9uZXh0LmNvbT4KPj4KPj4gRG8gd2FudCBtZSB0byB0YWtlIGl0IHRocm91Z2ggbXkgdHJlZT8K
Pj4KPiAKPiBZZXMsIHBsZWFzZS4KPiAKPiBCeSB0aGUgd2F5LCB0aGUgcGF0Y2ggc2VyaWVzIGlu
Y2x1ZGVzIG90aGVyIHN1Yi1zeXN0ZW0gZHJpdmVycywgc28KPiBzaG91bGQgaXQgYmUgc3BsaXR0
ZWQgaW50byBlYWNoIGRyaXZlciBwYXRjaCA/CgpXZWxsIHVzdWFsbHkgY2hhbmdlcyBhcmUgcGVy
IHN1Yi1zeXN0ZW1zIGJ1dCBpbiBjYXNlIG9mIGZpcnN0IHN1Ym1pc3Npb24KeW91IG1heSBhc2sg
bGludXgtc29jQCB0ZWFtIHRvIHRha2UgYWxsIHRoZSBwYXRjaGVzIHRvZ2V0aGVyIHdpdGggdGhl
CmFja2VkLWJ5IHRhZ3MgZnJvbSB0aG9zZSBzdWJzeXN0ZW1zIG1haW50YWluZXIuCgpBZGRlZCBp
biBDYzogQXJuZEAgYW5kIGxpbnV4LXNvY0AKCkknbGwgd2FpdCBhIGJpdCBiZWZvcmUgYXBwbHlp
bmcgdGhlIHBhdGNoIHlvdSBjbGFyaWZ5IHRoaXMuCgogIC0tIERhbmllbAoKCi0tIAogPGh0dHA6
Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZv
ciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdl
cy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3
aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
