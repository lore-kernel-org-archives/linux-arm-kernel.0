Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6825BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337F920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WdW468uj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeD/sUYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337F920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CSrJ+i9G/OojXunbnv2NCM8sjvfHVRyplHM+iuFW1Jc=; b=WdW468ujbfXGjv
	eXUzO5gA2VwKsTjfJXPZLw/x6sUW6FOJR3FzmzprTtLH2yeMFSWpT17X3O9obST3ES9sxEEqR+0tO
	06eRjggpW8hEW8bOKuZUmSF3bA7BSWs869OsQgkKX5SvSOYV350EPVZJxr/j0YdiIBBm87h2fWQji
	8iVQswnheRsKwHuh5F4FP6Y04lq0kzUYuMmDKGXDbKUh7FffLZzseCRDqvDs4gDCt60essbKqu2rc
	6YV/mCjlWUAZsZUJTk90N2/MVwSl7DFPHO9/28ZqqNYCCFdd2unCXWgAbUp5FsQPo+Ks0w8LjNgY1
	/3RPI6Rqs5pUYt3NcTmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUv16-0003xw-Md; Thu, 06 Dec 2018 14:52:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUv13-0003xZ-UM
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:52:39 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C5C1F20878;
 Thu,  6 Dec 2018 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544107947;
 bh=MRsFfAiB7zJRv1E1FcRfM7cU+O0/chX3GFCuJ6V2SSY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qeD/sUYKIPwb7gtvLaTmOIq6ofQGO4xA8x70qXiIYjqDprLsXYjwxQTpjeusJZLMR
 XmoEU1LtjYhte50tUCCUQ2zyub6AiQFIYHZcLSOPkMkLdNXK8KjOzwWseYKGbDRbda
 EWaQW1+gz++/4O6Et3u6XWlELiQ5eZIHu/PUTCow=
Date: Thu, 6 Dec 2018 22:51:38 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH V5 4/6] dts: imx: add common imx7ulp dtsi support
Message-ID: <20181206145135.GE12929@dragon>
References: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
 <1541862478-7839-5-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1541862478-7839-5-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_065237_996862_E7B6F50C 
X-CRM114-Status: UNSURE (   9.75  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Nov 10, 2018 at 03:13:08PM +0000, A.s. Dong wrote:
> The i.MX 7ULP family of processors features NXP's advanced implementation
> of the Arm Cortex-A7 core, the Arm Cortex-M4 core, as well as a 3D and 2D
> Graphics Processing Units (GPUs).
> 
> This patch aims to add the initial support including:
> 1) CLK
> 2) GPIO PTC, PTD, PTE, PTF
> 3) uSDHC 1/2
> 4) LPUART 4/5/6/7
> 5) LPI2C 6/7
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Changed the subject prefix like 'ARM: dts: imx: ...', and applied the
patch.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
