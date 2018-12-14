Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE7AC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:30:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D830C2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ga8gPohk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHxquHBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D830C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZOPE2+o8GsXGvrLpQuyqk7BOoPeU8sEjiNpl8dM6/fg=; b=Ga8gPohkf/Z36i
	7+PWcMhs0GTSj+3OKjGW71Jb8TnOYg88asKAPjsBAizO3eaFeuWpG2fGbdwc7Tqzey3B0dTyDnD2N
	lbv0q+q0Hbgw6Oofb1Qj1wm7CE9F4D6lxQWnT1WO7PqkVNgS3B0LRB0KNjbhclyL3ciIcrGZKCYPc
	68Gl2zZ+6fvdNJbkwggbRyWJVreRe8cj+S0W1GgBiiJHIwMN0PIwq2y2/97B6lGs+KdWu8LflVhcb
	K8tqrW10gjTAHIkZdtxb4w7EbXvraPW08kLpT+cHqCEzgr3qsnkHKVahEvD8MXsVw7MZ+JR1Z0kHC
	jmBCuMgQTzKm2+nlRNpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcJZ-0006oi-1g; Fri, 14 Dec 2018 01:30:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcJV-0006oE-N2
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 01:30:51 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB75120645;
 Fri, 14 Dec 2018 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544751038;
 bh=skZAWQDKTEsZekYxuQNHcn7w3KgrrCkKygExjrqQb1I=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=iHxquHBmMAxVyWHdMd4QeucWbhzc4TOMHAhyRDSwbsCLqwUdFIxHCxIvwrWQy73Ym
 KZUCPNrOseKm+VWRfJse4bI0wKlP4FsHXEf4NwPIjITVRISqdpFVr6GYY/ISV9wenC
 K/qQtYK8kiw6r4j6TSSDZeCg82Jn8beS9CjTVBXM=
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB42118C3E7F49A0437453BA5880A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Subject: RE: [PATCH V11 2/7] clk: imx: add scu clock common part
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-3-git-send-email-aisheng.dong@nxp.com>
 <154468728640.19322.12955855783518519739@swboyd.mtv.corp.google.com>
 <AM0PR04MB42118C3E7F49A0437453BA5880A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154475103791.19322.8783777114832958727@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Thu, 13 Dec 2018 17:30:37 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_173049_777885_5FFE258B 
X-CRM114-Status: GOOD (  15.89  )
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

Quoting Aisheng Dong (2018-12-13 03:19:26)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Quoting Aisheng Dong (2018-12-12 17:07:55)
> > > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig index
> > > 37478ba..5c26f4e 100644
> > > --- a/drivers/clk/imx/Kconfig
> > > +++ b/drivers/clk/imx/Kconfig
> > > @@ -3,3 +3,9 @@
> > >  config MXC_CLK
> > >         bool
> > >         def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 &&
> > > SOC_IMX8MQ)
> > > +
> > > +config MXC_CLK_SCU
> > > +       bool "IMX SCU Clock"
> > > +       depends on ARCH_MXC && ARM64
> > 
> > This should depend on the IMX_SCU config too, right? Otherwise compilation
> > will fail.
> > 
> 
> Yes, you're right. I will add it.
> 
> > Plus, I can't seem to compile this driver regardless, because the defines for the
> > CLK messages are in some header file that is just included in another header
> > file, and that is all going through another tree. Why?
> > 
> > Is there any reason why those defines can't just be written in the clk-scu.h file
> > introduced in this patch?
> 
> Sorry about that.
> Yes, it depends on PM service headfile [1] which defines all the power related service together
> by SCU protocol, including power domain/clk/reset and etc. 
> (we probably should divide them to get a better separation from the start).
> But Patch 4 depends on the resource ID headfile shared by most SCU client users.
> 
> [1] https://patchwork.kernel.org/patch/10664137/
> [2] https://patchwork.kernel.org/patch/10664125/
> 
> How would you suggest for this situation?
> 

I suggest the defines just go into the clk driver. Is that a workable
solution or does something not work?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
