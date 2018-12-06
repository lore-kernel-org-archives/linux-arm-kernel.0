Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C12C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D3320661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kB8ldc3d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivhKnJ33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D3320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p8L7smQ7b0SZwascMOGelC+ocAJYpinxfM68/sLDPro=; b=kB8ldc3djy7ycE
	Sep+uebiNLCFfGG/aJ5aUIJR0gO8jLc7yKyV2WHUZ8dzK6aZ0aHsY1IE7S0esQKsC+cdfSjYfIA+P
	nmbgF9q+KNcTx0615aw+7ITTlknWijVzFcYOaMVCGe8a5qnJHeGJfn5XffHFzBOTEpl9pjjeyhcjT
	FcZ6vTTFKtq5bCFYh1FqmRKDvq7JgcV9WTlJnnDDdJ3HY6NcPVrX55Bydm145F5v2/Moo0rjPAc/N
	bhZEBq5V4Hb3bt8HVcco7eyeV7aBVU/Y1/ElagEVzCm+BMt5p7eODWIArAtYzgx0TFgyEKkkdqGQG
	tEdCkDzNEqUBScrCaZvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuup-0001La-Vu; Thu, 06 Dec 2018 14:46:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuum-0001KH-OY
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:46:09 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9967920892;
 Thu,  6 Dec 2018 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544107558;
 bh=iz+LfiiVlGj0xBDoVN+mKe1G7C+Ozrvunr2XYrbqSGM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ivhKnJ33+/cg3i2LYjdsEhmgUkh8pd1RTOg32ocpNIGpbj63a0pJwzutzTIF0nACF
 cSP8wLbsodYAnC/FpcZ5sCeVXnYt8XmxThi8TnfbZtHfGryGMh6CSrpC0HkMUJvU83
 WUkCuxsIUTkOwvwSIbS4zlSN+mIoACfad/fvr7nc=
Date: Thu, 6 Dec 2018 22:45:11 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V5 1/6] dt-bindings: fsl: add compatible for imx7ulp evk
Message-ID: <20181206144508.GB12929@dragon>
References: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
 <1541862478-7839-2-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5Cv4+s7xxibCYFQTJ=1bwshfQQ17GBmKYDu-w3cFbxLDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOMZO5Cv4+s7xxibCYFQTJ=1bwshfQQ17GBmKYDu-w3cFbxLDQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_064608_811881_993149D8 
X-CRM114-Status: UNSURE (   9.70  )
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
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Dong Aisheng <dongas86@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Nov 10, 2018 at 01:50:13PM -0200, Fabio Estevam wrote:
> On Sat, Nov 10, 2018 at 1:13 PM A.s. Dong <aisheng.dong@nxp.com> wrote:
> 
> Even a single line commit log would be better here.

+1

I added a simple commit log and applied the patch.

Shawn

> 
> > Cc: devicetree@vger.kernel.org
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
