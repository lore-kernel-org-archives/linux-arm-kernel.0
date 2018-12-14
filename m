Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2FDC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:17:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB17420879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uwo1QjaU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K61BJvAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB17420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bm01aJFy3vKt3AaEdEbA5bWGAPlsJ5Ly7qbkaQ483Pk=; b=uwo1QjaUvCg7Po
	trkYuP3IB+s8ph9MQeTDywN0gwv4jdQN4HGtziU9jJHhJNyyrMvfTKrg0z7ChsGKB7uBDQtpoAShs
	5dy6rSUvJHNTsoXgeFWPt2bwfMKbw67l8PazgLEokmCl9OothZFQOzgVtn2hPgxRHAoi99lXZksCU
	pDgxQcx4XKCM6Qa7HVLK2DlYW6tuSoswY1ZoJd5dhUiDjozJP4Q74zo05402KEbpYpR9tQi0oFvsv
	LZDfih2ZKiEWZeWOpNXWjsOieEU80cc1AWM6FRanwm8N6A32BItJ+LdTbwEYvAZ/vDHIFs3pY3dbf
	Be0HDBr79qh4vZkpmVsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXd2p-0006YA-TI; Fri, 14 Dec 2018 02:17:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXd2m-0006NH-5k
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 02:17:37 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9560F2080F;
 Fri, 14 Dec 2018 02:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544753845;
 bh=D2FMTrDoBq33XMTC5E4WlE8VPn0hdiNp2AErRA8Mz5g=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=K61BJvApm3Gz4mrxl2B1KX12Mls6P8s2xMUux7K46KMA536CpWLOGYTBnxXHUyWZP
 E/A3uY4ml/9Vyv+u8lj+6PsaDLoGYLgZaM6hxFWRj7tjwrcEmKlXtBntg1DW8hSrVR
 LS7DaalrnKocjE3PqqveX/OIzQ36hpZocWARjiKg=
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211D584BCE4B6D06D57637280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
Subject: RE: [PATCH V11 2/7] clk: imx: add scu clock common part
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-3-git-send-email-aisheng.dong@nxp.com>
 <154468728640.19322.12955855783518519739@swboyd.mtv.corp.google.com>
 <AM0PR04MB42118C3E7F49A0437453BA5880A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154475103791.19322.8783777114832958727@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211D584BCE4B6D06D57637280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154475384479.19322.759264653632754113@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Thu, 13 Dec 2018 18:17:24 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_181736_231412_B02C7046 
X-CRM114-Status: GOOD (  12.05  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2018-12-13 17:44:55)
> > >
> > > How would you suggest for this situation?
> > >
> > 
> > I suggest the defines just go into the clk driver. Is that a workable solution or
> > does something not work?
> 
> Are you suggesting me to doing it now?
> As the patch is already in Shawn's tree, but I think I can do it and clean up
> the file in Shawn's tree later.
> 
> However, only moving the clk related defines into clk driver is not enough.
> The driver compiling still depends on the resource ID file which is shared
> by power domain driver and clk driver (and possible many others).
> So we still have dependency issues.
> 

Do the resources need to be defined in one place either? Or can they be
spread to all the drivers that use them?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
