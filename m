Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E2EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:56:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08FA20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cWDGZKqn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVF/S1nB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08FA20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cscFTVGK4oosUNgg7XKgWhksqQGVPjq392fAOP8TAfw=; b=cWDGZKqnn9d9q9
	5JRv+TkF8iHIN/Z/VYVe1bQDFsXWHCRsfWuq2muBOWdgM13loIDdgk3FYJGZhQgKuU9AK21Bz/On2
	0M6bPvHoBQHQHt4T30dKAGrGxiKWUowR5fyyW8NZ5m7L5DfpyGSZvAzJ8NKvG83lhVMvMgWX6RX4F
	KLOjgLTkRQ/95rWgOfWFSJ1iIlpHpaPc0H6+baEAYj9vxkerhtFNpe7r8qL7IfmCn60UCVnADfaVs
	nVzdNOzKjbB8c7uMub4dnbnvrCmewLwf5WZ/TwzmD9Im3inFYBSDOjixwQebCfnHUhV5wL2s8IF9L
	xY/vYlyztEXJz9dVW6LA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQ8p-0002Q1-U1; Tue, 15 Jan 2019 14:56:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQ8l-0002PX-V5
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:56:33 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10F5920657;
 Tue, 15 Jan 2019 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547564191;
 bh=ziATwU4L4RJH1GuedwsDiBohT0EEHGgaEfEeKJ38FMM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RVF/S1nBHM4GKoUdb8j4/twjlQajA3GpK5CraL0sLXcfb9Nks81EFSnTn5QVqiOrd
 yVxJ6yGDcgk36obdd+PN049VmGzeguQ/cRw1jzZFl8QnXkNP87pcMEIyfHgj3yakKt
 MNzRBQu1WSlR7Wqb0ny/BNZu7BnDXyzTUiUUCpzc=
Date: Tue, 15 Jan 2019 22:56:04 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: BOUGH CHEN <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6ull: change to use new compatible
 "fsl,imx6ull-usdhc" for usdhc
Message-ID: <20190115145602.GB13895@dragon>
References: <20181228033323.32308-1-haibo.chen@nxp.com>
 <20181228033323.32308-3-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228033323.32308-3-haibo.chen@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_065632_024932_6EDEB180 
X-CRM114-Status: UNSURE (   9.01  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 03:26:16AM +0000, BOUGH CHEN wrote:
> i.MX6ULL has errata ERR010450, there is I/O timing limitation,
> for SDR mode, SD card clock can't exceed 150MHz, for DDR mode,
> SD card clock can't exceed 45MHz. This patch change to use the
> new compatible "fsl,imx6ull-usdhc" to follow this limitation.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
