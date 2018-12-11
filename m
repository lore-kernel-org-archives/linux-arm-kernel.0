Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57578C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:07:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FE620672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m/0D/LcJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf8hipg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FE620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qooQ87JJpwIwBOAfogOQMa/Y/9yniI7owwHwa2lauUk=; b=m/0D/LcJqi14gb
	dD7zjk+oA5Vasd7WDnnJjS6+vVdMcMIQoq3oC2iAx6wtwbJQa+kUuhloxpndAJUeD7XhoxVEfsdop
	hYlCoplZHBtIT6euLCGTK2mALtBtcDO9OVoB2A5PN0Sd0l0GzqkgjBDP86WPgNypqpPdqLbsoJQaX
	KEDlN74JvbDEkK74SBUwHLFWeKo0daa5DFznSRXfNMYcsVU110dIOCQ1PjEdnwNmccMiZLodNXXK8
	b16hfT4NEkT0yxVMbVThujOWIymatE86mtAf1H7nmuRSLZfodrZSosLEMGS2WUsNXmGQOGulPUOon
	cJWwCE8cF8ZSZ8jAgqQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWXSD-0007XU-7r; Tue, 11 Dec 2018 02:07:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWXSA-0007X5-WC
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 02:07:20 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2E67520672;
 Tue, 11 Dec 2018 02:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544494028;
 bh=3EWuECZ89Cq20rrWW4jIFeWaGqnt3LRX1TcshXfW4BU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xf8hipg1KwBHtmJo/S1l9YX2xXW38mbwx4VAEUQVAOn2R3Mdn1G/VJH7LvUty4EYK
 inANAUHKi0mVcc0E+GDZTJiyPYafO7pZSXWP+KyB1ULwlvjHkAfC98AKF7wDZgq9ro
 aI58hACar9VY0+CInqUcC4WP44qRP4+hhCA/Y+lU=
Date: Tue, 11 Dec 2018 10:06:16 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: imx7d: sbc imx7: add uart5
Message-ID: <20181211020613.GR3987@dragon>
References: <20181204110741.6943-1-hohatzel@jusst.de>
 <20181204110741.6943-5-hohatzel@jusst.de>
 <20181206031520.GE3987@dragon>
 <58a84012-73b8-1679-0c5b-981fd2a0acd6@jusst.de>
 <CAOMZO5At5oSv0MCpsuYj4nEd26Y4h9hj-shadq3477fNz8A+HA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMZO5At5oSv0MCpsuYj4nEd26Y4h9hj-shadq3477fNz8A+HA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_180719_059362_786D6BAF 
X-CRM114-Status: GOOD (  16.23  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, jscheel@jusst.de,
 NXP Linux Team <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 hohatzel@jusst.de,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 09:43:12AM -0200, Fabio Estevam wrote:
> Hi Hans,
> 
> On Mon, Dec 10, 2018 at 8:52 AM Hans Ole Hatzel <hohatzel@jusst.de> wrote:
> 
> > imx7d-pico.dts does this the same way. Is that good enough of a reason?
> > If so, should it be included in the commit message?
> 
> The UART clock parent initialization has been removed from the imx7d
> clock driver since commit (in linux-next):
> 
> commit ea662d2f804ad13c3c92c75c7dc1abad30e31c31
> Author: Anson Huang <anson.huang@nxp.com>
> Date:   Fri Oct 19 01:05:36 2018 +0000
> 
>     clk: imx7d: remove UART1 clock setting
> 
>     There are clock assignments in all i.MX7D dtb files for UART1,
>     below is the example in imx7d-sdb.dts, so setting UART1 clock
>     in clock driver is NOT necessary, actually, module clocks setting
>     should be done in module driver.
> 
>     &uart1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_uart1>;
>         assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
>         assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
>         status = "okay";
>     };
> 
>     Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>     Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> 
> So the UART clock parent should be set in the device tree.

Okay, but would it be better to set the default parent clock in soc
level of dtsi, since the configuration doesn't seem to be board
specific?

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
