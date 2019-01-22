Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0BDC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:02:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2BF21721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D0ofI0g2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="flmIip5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2BF21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BzXKnIXj2Ze0LrRaSBJtxC8h1aia5ggLpmh/XqSZSV4=; b=D0ofI0g22G6ay9
	rRw/2g+pen4IfQlkRyiOhh0gEqdOXztcKDHLi5onXpE72YjaPHQbbCYtteyncR4/Hp/az9zMerjoO
	G8f5ruC7FSgBcl/TZZJlUnobS6zVyyUVLPtxdda78Sn/PKT2csVaRXs/C+166m6ZHa0NpSsfGqnep
	8wnrlax46yHNfTrpo0WC0E39d/f3mh7gTvxb69YSAIJLOwAJifmHEBax5LGvV7Zo6vNLW+prPWnr7
	D/yKtb03RNxrRyQjlWHoq6ib7b2jJnwSwrC9nCHXyxee+VO2FRFXOAvFaBoSH80ttGqvN4EDt4HIW
	9GPOkG4MRa3uKzFSfajg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glp8l-0001VC-2E; Tue, 22 Jan 2019 06:02:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glp8h-0001Us-U7
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 06:02:25 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 80DDE20870;
 Tue, 22 Jan 2019 06:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548136943;
 bh=TunUp5w39QcHe/ox8e2z+750VQ/9DLwuXP3dMRE/GGI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=flmIip5t8vo7NtF0fl1B562/f9T6SA51J6DbshaavseJV7c81Tqx8bc0j1OZvP4s7
 E9MNjMLyuAtpPa2dwPyzkqLQQ2cKW1OnwVRJpemrHCmUYvj/JujFZ3fK4hrrdfPCy4
 OhobEu/Rv3qZvWfBG2Mbnv3IkU7h18/mT1zgdrHc=
Date: Tue, 22 Jan 2019 14:01:42 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] ARM: dts: colibri: use valid range configuration for weim
Message-ID: <20190122060141.GB19929@dragon>
References: <20190121155327.12554-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121155327.12554-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_220224_025389_F416EFFB 
X-CRM114-Status: UNSURE (   9.23  )
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
Cc: marcel.ziswiler@toradex.com, s.hauer@pengutronix.de,
 linux-kernel@vger.kernel.org, max.krummenacher@toradex.com, dev@pschenker.ch,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 04:53:27PM +0100, Stefan Agner wrote:
> A valid WEIM range configuration must specify range entries for
> all four chip selects. This fixes an error on boot:
>   imx-weim: probe of 21b8000.weim failed with error -22
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
