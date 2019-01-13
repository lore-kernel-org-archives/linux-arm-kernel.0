Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC28C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:36:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4D920842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WPuFied0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW/gjgdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4D920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b3Io2/uFAE5GDYwB7PW3AdAtYatuU0lvc1DRFKpMV5Y=; b=WPuFied0tCiYi4
	+qBCQb44VAnJrH6/lRKXY41zUnmmvXyQcQP7x+TM9cjmzCpYndZTLuhPly2QFQ9nlactJM1s61s8g
	Jguuxw/YdNzoGoRRrA48G30D5HdVda3iv1ZmuK2q7uhwxPinKn3HPX0jMacQCuMS3ekkT1HCYoXMT
	suK+Jo6fKW4VUObZTM5GLTfN2Pdj1gwoSTmI/cxxVpf/3B1zMuEmqnElHTxG6yzi8MMoqUE+L/Zob
	ASbDtxC/tIcs3/vW4RqdEw1phXJNvqku/YOTTqJFuCgRdjrNdYuOkCorM3s30L1yFQa2EyYMIUlpC
	T2DY/j+Y4FnVWleJZzTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giWZh-00014R-Ac; Sun, 13 Jan 2019 03:36:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giWZe-000142-Ac
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 03:36:35 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7DF9D20842;
 Sun, 13 Jan 2019 03:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547350594;
 bh=bsAvnT/O+HhK0bVxJN/mwntmaRqADEppJty1Tdh41YA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SW/gjgdVJdYa+WujbnaZlQS1MWC1yBU0oNAmmuel/nKKsPSz0fHP2Fim8I9pfRjnB
 MlN7M1SS/H8pwmnx7NOanlLBh5qnwFcz0UlEF4u/WFpRaBT2m4XyHdTLf811urAVma
 jpaS3Fde5waPO/SoyeePk8uJISfu04kdoOVxcB0w=
Date: Sun, 13 Jan 2019 11:36:16 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH RESEND] ARM: dts: imx6sx: Add DISPLAY power domain support
Message-ID: <20190113033615.GJ11426@dragon>
References: <ca5d7f6be8e1cf7ef9b5c8ef322fbcf1a14ae7fa.1546866930.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ca5d7f6be8e1cf7ef9b5c8ef322fbcf1a14ae7fa.1546866930.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_193634_401523_1AE43628 
X-CRM114-Status: GOOD (  11.59  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 01:28:48PM +0000, Leonard Crestez wrote:
> This was implemented in the driver but not actually defined and
> referenced in dts. This makes it always on.
> 
> From reference manual in section "10.4.1.4.1 Power Distribution":
> 
> "Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,
> PCIe, DCIC, and LDB. It is supplied by internal regulator."
> 
> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
> actually inside the DISPLAY domain. Handle this by adding the pcie node
> in both power domains.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
