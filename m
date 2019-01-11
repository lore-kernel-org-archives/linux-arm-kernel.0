Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C290FC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:36:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC042133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t5LoswZt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MQyAViwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC042133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rI9YlltTRxyLM2bHKlFv/V2i/C48bN0Z+wM/TdC/+u8=; b=t5LoswZtmZgFmp
	0YPW+vaaK741cl3/L2V4PrbPtE1GRA4Xb08qIgOVXfrCYy/QGs3cR95Q648fPOzwNPG92771SsyAL
	Hbh3sB+dAW6ogXThndQSgz2h7LJs3Gfg8qwCyZGlcdAudUpMASGErbuknF5nRz3YHzhqFKU130joK
	B2vA2/5Wt/8Rk0k9gTKyQz1JhGLENcTph6HSgLAZUvdxjRN8LyM8gNVrWw3aHw080VQPq/ZYApCgN
	7LNFoISs2jeGSpHQ7uuJ8bSyrq01NmJMFUmNlgtsKipp4bM7T6vRJVZjISiki6lhBV0NuQdAHDQec
	gRCNKgSwyrLW+GKUxzSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghkoN-0006rI-Bw; Fri, 11 Jan 2019 00:36:35 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghkoH-0006pk-PN
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 00:36:31 +0000
Received: by mail-pf1-x442.google.com with SMTP id g62so6070728pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 16:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=Tg7Of7yfTzZ306F/K4qCSlYHP5A6DxEIoqC8M4YN+vY=;
 b=MQyAViwSN01pOAfrrM921Gs4lkY0lyizOADbno1ks5RZ+GlZihXvS9GJHc1b339YxN
 /cVWpPBuoAoQ4EtdGPktE1ljnwJsSRk0kmuOWC1vzcg1pgDU6tLEerT7wIPLDEJe8yNR
 57+eAmCXE5eukDsM+LgGwevXqNKGYFvFfAvvjFpy+W8TF8SBj+tK/YkdHh65rouxO22q
 2eewIBkwXZeRmiVXNwHYG0VtdL6AF9tzAxG2LZ+RgWKyzkUiFQm6OoVPxb+lQihjfa8W
 3yCbm20kK7P5J/0eX8YSCF4bhu7W6LAAH2/MxFJw8DqRB+zkSWUXGIDGA5rRSsgNmAi4
 TP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Tg7Of7yfTzZ306F/K4qCSlYHP5A6DxEIoqC8M4YN+vY=;
 b=lWQplT++CyPsIF+8de45taRpW7h5ZQ41PjM789+158SnK9dalnVy6Sg2oFbOdLg5uv
 bXTBLy25/M4fQYzEj3OP7YyYsfwlkpzdmEGn/70wx43Yiz+KOX0PcvrxRIXunRiRJTyP
 bwR2Vs8jp18Wcq1Wh85PAmA04En1g5AI0DpW51PlJF/EEQ1ZquISq79qwUSXYNTRQ7B3
 7quknKho+gWyhXiCP71RpWd3aaogT7EpW+/BGd6KC5nyGvsmHKgJ0G3kz62dViWBgcZx
 qfoD8cKH2bU9guiCxKseoC60RdQxqbq1DEpt8Q6JsAfeRvm1gTMK6aSWgg/gFlGcKtmB
 iHrQ==
X-Gm-Message-State: AJcUukfabuvFeIp8d8KHJWXimA3U1XnyqQ2+HzontU5o6EjeCFiiqxgH
 Y03YomalTCwz5nlIpbnnombSrA==
X-Google-Smtp-Source: ALg8bN66d6XtM6IH1M/QANv1bw6+4LfmMjOinIvMqGnH63lRt0UZyynMHQzdIY1RzhQg6Aj6pOyFgw==
X-Received: by 2002:a62:5793:: with SMTP id i19mr12431040pfj.49.1547166988352; 
 Thu, 10 Jan 2019 16:36:28 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 g11sm107288074pfo.139.2019.01.10.16.36.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 16:36:27 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 0/3] ARM: dts: meson: add the APB/APB2 busses
In-Reply-To: <ba3e4fef-7a18-8c7d-e0ea-05c541b29913@baylibre.com>
References: <20181208165025.27689-1-martin.blumenstingl@googlemail.com>
 <ba3e4fef-7a18-8c7d-e0ea-05c541b29913@baylibre.com>
Date: Thu, 10 Jan 2019 16:36:27 -0800
Message-ID: <7himywqbck.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_163629_845832_EFA93FF4 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 08/12/2018 17:50, Martin Blumenstingl wrote:
>> This adds the APB bus on Meson8 and Meson8b as well as the APB2 bus on
>> Meson6. This is preparation work for adding the Mali GPU which is
>> located on theses busses.
>> 
>> Meson6 seems to have it's APB at 0xc8000000 instead of 0xd0000000. The
>> region at 0xd0000000 is called APB2 or A9_APB and it has a different
>> size (256k) compared to Meson8 and Meson8b (2M).
>> 
>> Addresses and sizes are taken from the Amlogic 3.10 kernel sources:
>> - Meson6: [0]
>> - Meson8: [1]
>> - Meson8b: [2]
>> 
>> 
>> Changes since v1 at [3]:
>> - re-send the patches but this time don't include the old patches
>>   which still had a typo in the patch description (ABP vs APB)
>> 
>> 
>> [0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson6/include/mach/io.h#L61
>> [1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8/include/mach/io.h#L53
>> [2] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/arch/arm/mach-meson8b/include/mach/io.h#L53
>> [3] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009424.html
>> 
>> 
>> Martin Blumenstingl (3):
>>   ARM: dts: meson6: add the APB2 bus
>>   ARM: dts: meson8: add the APB bus
>>   ARM: dts: meson8b: add the APB bus
>> 
>>  arch/arm/boot/dts/meson6.dtsi  | 8 ++++++++
>>  arch/arm/boot/dts/meson8.dtsi  | 8 ++++++++
>>  arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
>>  3 files changed, 24 insertions(+)
>> 
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
>
> But frankly I'll squash the meson8/meson8b patches with the mali node patches !

In general, I agree with Neil.  Adding the new busses along with the
series that uses them would be fine, but I don't have a strong
preference.

So queueing this series as is for v5.1 (branch: v5.1/dt)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
