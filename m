Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:35:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD6A20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YAiqfxs5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBgxqFtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD6A20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7qYDP14e4Yzqhin653Ac5jo52nh/d03oeBG6kV5cMDg=; b=YAiqfxs5Wg8OAd
	VqBSWu6SpFTZBwVd5Yesmi/PfidjP4Evsdyr05+jgJK/8G+T+22DB7snCPik4BSEmwmeVHH/y3iZ/
	4T19jexYA5wOSdu4/TPR3iRmIt2JzU3QnGKfHBBI4B3Bmj/TLKzeJUC751CPsDA2vgCJ9H/4Qqa7o
	FsyBk6Lm0tqgvX7qwvyGVhpStXG0Y2QoRBvXyhNhw8+3Iji0g+RDdMk94LecPMfo4tXAT+FGOaFKd
	xXQ618yO0LEykM2ftU3rOCWfbVUVH9kbRlTOIQcF6UvxzPIcIXCHO+vNDZ3/em3pc9l/OPOZnjBx6
	xLt0myFOVUaiec9esUkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giWYI-0000mG-PZ; Sun, 13 Jan 2019 03:35:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giWYF-0000Dd-MU
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 03:35:08 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 76BB720842;
 Sun, 13 Jan 2019 03:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547350506;
 bh=u2vMSmIuHlfqXLVniFjN6O/rjGNGMR1DQYLP94HDR7w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uBgxqFtARHwLBPCtpLCIUetEV0mdwg+ENhaTHCpFPMQOXBccFOSRnIrP/HRk35rh7
 /yby5655BFeCB2tThHp20GNdEmX5WD41AwTS9+XqrsmZkeg1lK44paH2XClU1AID1f
 6H3qsd+2DZJUAaZmL/As2JW6jWBp+vZL/Ln8C+CE=
Date: Sun, 13 Jan 2019 11:34:50 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: add DMA properties for ECSPI
Message-ID: <20190113033449.GI11426@dragon>
References: <20190107132226.16216-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190107132226.16216-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_193507_770165_4F48E222 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, s.hauer@pengutronix.de,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 02:22:25PM +0100, Stefan Agner wrote:
> Allow to use DMA for SPI by adding the appropriate DMA properites
> to the ecspi nodes.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied both, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
