Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68935C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:16:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F81820844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VInTpUYK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="oXZZYr1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F81820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l0DH7nHkhlBGR+Of9TksRx+M50c/hhg9jBNxxRlVz20=; b=VInTpUYKPoV1kwuBAXL3ZxOjc
	GM5l56AAglx6JerGNVyRp5FxJW4fgK6BrvHVIkEaV1+W3wU315wrEiuQdcvnKig/ssGAcOCEqUgCA
	BOAyMhll1aA/QiFLAQ/f9yKId1uJjnx86kDecK9zRecq37YCsbhfXxIqZCQaipxAKW8lj7dORlLsP
	PQ4YmA+ruBMAckMZVROeoXwY2yFkFcknY2fNnNRVpzY8BfM75hHx6uYOLqrhREzemlcRM8qy3sj2w
	0KtlscCVYcbsFZMlbstp/PAjyHmsKR8eXWZEfnLMauOUFzIzuRBWaM8JgOIYbTViLOyOy6rfrNUVV
	aglqB88Vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqqHo-0002pJ-3i; Tue, 05 Feb 2019 02:16:32 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqqHl-0002on-6p
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 02:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lLrqOBtSViQA2wCXVQlz2enVbxgYHmowKusSCboT5og=; b=oXZZYr1DQTIRRCyM3GzH3Ai2e9
 DLDRV+DwqnwFYfQ7wnl4CwLkeU0ccjp6ukU6wimYFWz3bvs54jjI1opT+h/FLrv/Y0Gt033BPxdaf
 VeHPaEiXz8/qs19PEDuv5R28iFY7bfI6dIH0mlGZVHd7h2Bh1SpwqbkASIWsijATdkYTOJ4nDvpfc
 gllS28oHCZQdBzU79bYjwyucbm6JPCvfqEiTubyHeWniXivHBT9xxXsgjObjhLbaypA6tZehBEphL
 fMU+iYuDKd2Bly0OnWZj1YYQOtFNr4Tx0EW92xGt7D5d22ykuOZWAqF0RVrQxHPdAmmSaGF0u9JE0
 PMMPrSgw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:34204 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqqEF-0003tK-Cp; Mon, 04 Feb 2019 21:12:51 -0500
Subject: Re: [PATCH v2 03/12] ARM: davinci: enable the clocksource driver for
 DT mode
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-4-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <e2276265-7c20-81d3-6e55-ddff446c7e54@lechnology.com>
Date: Mon, 4 Feb 2019 20:16:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204171757.32073-4-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_181629_334079_216EF373 
X-CRM114-Status: GOOD (  11.80  )
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
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/4/19 11:17 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Switch all davinci boards using device tree to using the new
> clocksource driver: remove the previous OF_TIMER_DECLARE() from
> mach-davinci and select davinci-timer to be built for
> davinci_all_defconfig.

I don't see how this patch is related to davinci_all_defconfig.
It looks like the new driver is just selected when ARCH_DAVINCI
is selected in Kconfig.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
