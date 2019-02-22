Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D52C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:37:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17847206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h2ggI8Qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17847206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZFtGPSxbKgZivtAuKHxWl7DmPljZ2vu/8+ynQprUGJQ=; b=h2ggI8Qku7oiwJ
	CVWv1iWigL7W+SqlLM7yGmVxsb6I6dOozKYaMzVizhk96gHo3bTdlSGZEgGTJnquBYP6gE5WrZO7c
	qeuzpJYdwwpcH3DyMweNldh2Ww2DB65gGm3t3SVbgKWITqq2wFINTtpQ/SH4kpSVThwFMFGL5Dl2q
	qQSHZ1Dwtbzro4bf0Y69CILNJWp50JsvDvmJ2RexRJCz/hbyAPhbyUG9zuOLqd/fGYdhwjD4UAufn
	b/q33OQQby6Nxe0ha0MGTgESUOTEXok5AXneV+T26HJPnAM9Hvu8a8+NJv/kknprqVz9HYV/TUpD+
	/0/LPrzpqfNFLe18eGgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxElc-0005UL-EL; Fri, 22 Feb 2019 17:37:44 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxElZ-0005Tw-91
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 17:37:42 +0000
Received: by mail-oi1-f194.google.com with SMTP id b4so2339731oif.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 09:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZGQIM3GpgLZbnfp+DGR8UCIwyuFKStrA4F203lEZjdg=;
 b=VtI89LZ3PZV7kxHlvaklwNCFpUQ6X4uimgmSs3qR+9LV+kJegPHo4y28EpylnsglUX
 nFq4a4JHTDfKkubIrpVQxYmHM657AFZDEsjb3j7hvQSzkWEo6gksBRlYxrvhFSkRT3xr
 nUEtjxTlPGJjS1GR4qw2KLUnxaWwn94ByyzSFXrvU9NcIKSDYaHpD1KgbJlE2//01Qgk
 s+Y2OwaplKgWXEqlkdUWbV9gLGqPsFJmGXcTIEphwj/DC9CID8WQ4s98GjINcbYhrWvR
 Ge6urkkG3Dns64mDzs3u7GJ1xB55TpIN+CC8WdnWWOyBN6FIA9wYNgAZSrDcAaKtZfXy
 XDdw==
X-Gm-Message-State: AHQUAubrEAtIh37RzFGLOfVQCSYIIf7bhRI9nnqV3vxDBxDGzd8m68bp
 SKir4GwkfOYe/FkzysiEbg==
X-Google-Smtp-Source: AHgI3IZUfBK9YOhRiNGj5F8GS3/KiwiNW9Rro1YvobOAtrHDZZVXK/BrseZVXFxmCt4lGYSTEbLUFA==
X-Received: by 2002:aca:3a87:: with SMTP id h129mr3358649oia.86.1550857060131; 
 Fri, 22 Feb 2019 09:37:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r9sm750565otp.81.2019.02.22.09.37.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 09:37:39 -0800 (PST)
Date: Fri, 22 Feb 2019 11:37:38 -0600
From: Rob Herring <robh@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH V4 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead  of group number
Message-ID: <20190222173738.GA2168@bogus>
References: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
 <1550662447-8565-2-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550662447-8565-2-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_093741_319039_20E9E475 
X-CRM114-Status: GOOD (  15.69  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 20 Feb 2019 11:40:40 +0000, Aisheng Dong wrote:
> Not all 64 interrupts may be used in one group. e.g. most irqsteer in
> imx8qxp and imx8qm subsystems supports only 32 interrupts.
> 
> As the IP integration parameters are Channel number and interrupts number,
> let's use fsl,irqs-num to represents how many interrupts supported
> by this irqsteer channel.
> 
> Note this will break the compatibility of old binding. As the original
> fsl,irq-groups was born out of a misunderstanding of the HW config
> options and we are not aware of any users of the current binding.
> And the old binding was just published in recent months, so it's
> worth to change now to avoid confusing in the future.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v3->v4:
>  * add more commit messages to describe the compatibility break
> v2->v3:
>  * no changes
> v1->v2:
>  * change property name fsl,irqs-per-chan to fsl,num-irqs.
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
