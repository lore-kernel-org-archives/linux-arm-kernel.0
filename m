Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DD0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:37:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CB22084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rdMSuFxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CB22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dlrlEAwG+LPtIaWiRkoNP780Wg2HRKY2+rblHJE7ES8=; b=rdMSuFxA7ZiNcW
	MeRQAV/9va0jL3LHib7Q89Dj+rp2FQbh6SUGZEXMbQjmbiZg2b9AHmvXLenuYCZbOTKTzI+z2kIKS
	GRfJyF/GOSYJQK3BfgsyvD/M87TvH53kdw7MwpLGbCRyqv+rs2+tKp/aloMDfvHTxLOB9JYOAXPT4
	RCMeP7i9HJvwkX9QBlJMRN1YVbU0ZwEMqJFzFbOpS3kQ4evB2igVe66jbTQAiWupQck5cNoLxRrqn
	xqfhjl2PLTnlI1EdxQg6oN740XnPrEkJtfI900CvZBbxfe4HCFRV54BHUiESZpGFJoRisCsPUmo7c
	2fmCILJ1ItR61FwE/m8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giQyF-0001yN-B5; Sat, 12 Jan 2019 21:37:35 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giQyB-0001xk-AE; Sat, 12 Jan 2019 21:37:33 +0000
Received: from p54b26ced.dip0.t-ipconnect.de ([84.178.108.237]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1giQxr-0007Er-1G; Sat, 12 Jan 2019 22:37:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Pragnesh_Patel@mentor.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: add ROCK Pi 4 DTS support
Date: Sat, 12 Jan 2019 22:37:10 +0100
Message-ID: <1646372.YqHRDYLcbR@phil>
In-Reply-To: <20190106044030.1484-1-Pragnesh_Patel@mentor.com>
References: <20190106044030.1484-1-Pragnesh_Patel@mentor.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_133731_509740_6B09C314 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>,
 Akash Gajjar <Akash_Gajjar@mentor.com>, linux-kernel@vger.kernel.org,
 Vicente Bergas <vicencb@gmail.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rob Herring <robh+dt@kernel.org>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Olof Johansson <olof@lixom.net>, Levin Du <djw@t-chip.com.cn>,
 Ezequiel Garcia <ezequiel@collabora.com>, Liang Chen <cl@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Sonntag, 6. Januar 2019, 05:40:10 CET schrieb Pragnesh_Patel@mentor.com:
> From: Akash Gajjar <Akash_Gajjar@mentor.com>
> 
> ROCK Pi 4 is RK3399 based SBC from radxa.com. board has a 1G/2G/4G lpddr4, CSI,
> DSI, HDMI, OTG, USB 2.0, USB 3.0, 10/100/1000 RGMII Ethernet Phy, es8316 codec,
> POE, WIFI (for Model B only), PCIE M.2 support on board.
> 
> This patch enables
> - HDMI Display
> - Console
> - MMC, EMMC
> - USB 2.0, USB-3.0
> - Ethernet
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> Signed-off-by: Pragnesh Patel <Pragnesh_Patel@mentor.com>

applied for 5.1

Thanks
Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
