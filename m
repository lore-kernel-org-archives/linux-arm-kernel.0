Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD76C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:22:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B8520657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tMpd1i8l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vWToak2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B8520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I37kz83BkqnAeloRK4ZQc7sxDF2THXpc0UUiDgRllzc=; b=tMpd1i8l8nVjht
	m/VtRqZcOZcNGsR0JTQT+LlBc6iuYpv0WIPE4bC16Gh7T4GJZQTTISP9TJv4/EZ4vfpqH4q+4a0sT
	E2w5py6BcHOXt+2wpQ3jY1ggFLcRkOAUxnaHNO/rTc9AQUocDx6K54udnLTO/Cq3A04RqcbP054tK
	SkzB/zy1vlnm1g6uUyo0m9wsC6qpzB+Ob2VJP53F423T/WTYuePnNQns+EfriV2VU9ShZvrWVP2D7
	SMidUAvo4am6WfpSX/vUBkxPbNb+ewyk5UL0Zxy1N+SNLNbf3OCb8Yvv70N2CLbHyqeAPgFd1WymJ
	Icse2UE6rgq9V4Ctqegg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj1G4-0008GZ-1O; Mon, 14 Jan 2019 12:22:24 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj1G0-0008GB-Qn
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 12:22:22 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ECM5hu022736;
 Mon, 14 Jan 2019 06:22:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547468525;
 bh=pomoWjXu4RCf3I1O8QUVAUkXL2nJYqEeNElihQ5YGko=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=vWToak2UyxfbpQ0zZ3dgwsL5ey5gy9OiN0eko5gxKjfdfiHSAd9N0jp9EcYvXY4ol
 AJg6MF/7n7tw0XT04sawyiTbAwohMR7inNzkVf9+xoG9pUIkLsQRdbZ1ZdvoJg4cSE
 DfUW+buB/uaWRkkFumYydUZBKn7IFFINLrS2BQ6w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ECM5So030284
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 06:22:05 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 06:22:04 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 06:22:04 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ECM1kO010732;
 Mon, 14 Jan 2019 06:22:02 -0600
Subject: Re: [PATCH 04/17] ARM: davinci: da850: WARN() if clk_get() fails
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-5-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <fcee383c-f2cb-1faf-d2a3-a35a17d57b8b@ti.com>
Date: Mon, 14 Jan 2019 17:52:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111172134.30147-5-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_042220_916514_19B2BB3B 
X-CRM114-Status: GOOD (  13.74  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently the timer code checks if the clock pointer passed to it is
> good (!IS_ERR(clk)). The new clocksource driver expects the clock to
> be functional and doesn't perform any checks so emit a warning if
> clk_get() fails.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I think 4-9 can be a single patch. They are doing something very similar
and its unlikely we will have to patch/revert just one of them.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
