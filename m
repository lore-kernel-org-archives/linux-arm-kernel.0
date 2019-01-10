Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A78C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:43:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A24214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jl9Ir5uP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEC0+MYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A24214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K5vbqi+Eei24MRH8oDgOnFnjObm+bvlae6mQPlrH2vk=; b=jl9Ir5uPhF7hrg
	D+JBgTap/Unr6c1MxXoT/VRYuFbTbbDf7+olshOBOYTSAPA3IGQ/Nhc7Yfw3RZzZwMf5Q6XpRbaNP
	z/5/5AjTkSjZ/QSI/aO7VJ15bRhxL4fa6Hj8gH32xCdIPLuX1q2L8lFqn/q4JKdE/5dJU4nAp66MA
	BQ0s3n+k8SlRWtu8Wiq11cWcpGePib+54metzmCYtTJ1OPDytr2mV4GnYJO2pqLXK6CDPtzaJPEXC
	ZsYxSkrx2bzdaEUzwuD6oa/D11vPonzgAQiiKY1m6d/u/BBzJU/OcD4Jm24OaITR3fo/jSGLv+3OR
	UkpxtFC9VTHBE3mApfuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghU3d-00083z-Ob; Thu, 10 Jan 2019 06:43:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghU3a-00083g-St
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 06:43:12 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D3C8214DA;
 Thu, 10 Jan 2019 06:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547102589;
 bh=RVtjTyJLKGFZRuEyHVwDNC25dNgB7DPh3M6yv0AsL0M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VEC0+MYihO2xcOYklPJZ2ZAwMQn9gHz1qI2dN5IOd0aminomj7v2FH99hb7vho2jG
 h4Xz5yD8faC9jCETbZfSQUGFeU47X5slJpmp2VP2GPaVkDUWJE19ohXjEKa3Mu22aF
 Ibw5h3xxK5g2mBet7l395qed6BpaYq3WfkIZ50L0=
Date: Thu, 10 Jan 2019 14:42:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc
 bindings to json-schema
Message-ID: <20190110064256.GA25218@dragon>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org>
 <20181206023140.GZ3987@dragon>
 <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
 <20181208015835.GM3987@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181208015835.GM3987@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_224310_949725_9AAAEE93 
X-CRM114-Status: GOOD (  14.35  )
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
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 08, 2018 at 09:58:37AM +0800, Shawn Guo wrote:
> On Thu, Dec 06, 2018 at 05:33:13PM -0600, Rob Herring wrote:
> > On Wed, Dec 5, 2018 at 8:32 PM Shawn Guo <shawnguo@kernel.org> wrote:
> > >
> > > On Mon, Dec 03, 2018 at 03:32:07PM -0600, Rob Herring wrote:
> > > > Convert Freescale SoC bindings to DT schema format using json-schema.
> > > >
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: devicetree@vger.kernel.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../devicetree/bindings/arm/armadeus.txt      |   6 -
> > > >  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
> > > >  .../bindings/arm/compulab-boards.txt          |  25 --
> > > >  Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
> > > >  .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++
> > >
> > > Rob,
> > >
> > > I do have any changes on bindings/arm/fsl.txt queued for 4.21 on my
> > > tree, so please send it via your tree.
> > 
> > What about:
> > 
> > c386f362957b dt-bindings: Add compatible string for LS1028A-QDS
> > 3671cd57de06 dt-bindings: ls1012a: Add FRWY-LS1012A device tree binding
> 
> Ah, sorry, I only checked on imx/dt branch and forgot imx/dt64.  I will
> drop the changes on fsl.txt and update fsl.yaml after it hits mainline.

What happened to this?  It seems the patch did not hit v5.0-rc1.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
