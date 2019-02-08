Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB5C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:07:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F47C2080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QYfZhkqw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JP2h83Dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F47C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZttPli6iWRqXszKrnx3zdQyO9/NSZidu3gYTWjEr09s=; b=QYfZhkqwY+OG5D
	hNJfridr4I4jfI8g1ubOGqioolpR29g+rNMRNfV371I/uoikokfidOvF7uN57tbg9luFfV4C3cIMv
	qE1HVX1CMz0Y+WdwhY4L4MPOVyTDQDI6tp/VqBAXcw6blQ/KEptQWy0oFXYVg4DSBbSzMpTtmfSZR
	y5X73DfcTMuyshkyqEX3y2QIIv5eHsAdORQqNNHIT0v//TZDujJpE/d70onhCfJ2AVaFEFCQj+zos
	/vhV6jqHDsf09OUxiIKTJDxrHdVgahI/L2odDiW2SFYuIcWStotIi2WpzAZd7NMuoLoYoNlbxINT3
	3dsgw1oithy9ffiuQsnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs33k-0002Tc-VC; Fri, 08 Feb 2019 10:07:00 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs33i-0002TD-EX
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2clESUS/EGGsK88Gda9NU/o91IOx04wP5whpWbOEsrU=; b=JP2h83Dw7soOYYoJwYbQDyQYo
 FtbnBRlh4iJM2ydHBrLFo0/3uwulGJmYwgen4R4tTEwgcstBidinvDvohGysGmHuxpP/hWfhFJOxD
 aDlhCXgVyy7Mvs0NOeaxboD8GVpl4e3LhQ5qidj5kbwbQqCKz0O0KflCgb64e4ww2duc0=;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50980)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gs33X-0007nM-Mr; Fri, 08 Feb 2019 10:06:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gs33V-0006yf-Mx; Fri, 08 Feb 2019 10:06:45 +0000
Date: Fri, 8 Feb 2019 10:06:45 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v2 0/6] Add comphy support for Armada 38x
Message-ID: <20190208100645.pkv6dwy5p3nepq6s@shell.armlinux.org.uk>
References: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
 <20190207.181049.1229639710283404215.davem@davemloft.net>
 <20190208085821.7556a18d@windsurf>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190208085821.7556a18d@windsurf>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_020658_490217_BCA9160E 
X-CRM114-Status: GOOD (  14.68  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, jason@lakedaemon.net,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, kishon@ti.com, robh+dt@kernel.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 sebastian.hesselbarth@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 08, 2019 at 08:58:21AM +0100, Thomas Petazzoni wrote:
> Hello David,
> 
> On Thu, 07 Feb 2019 18:10:49 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> > Date: Thu, 7 Feb 2019 16:18:25 +0000
> > 
> > > This series adds support for the comphy for Armada 38x, which allows
> > > these SoCs to use 2500BASE-X mode with appropriate SFP modules.
> > > 
> > > Tested on SolidRun Clearfog after updating for the 5.0 merge window
> > > changes.  
> > 
> > Series applied, thanks Russell.
> 
> This series contained:
> 
>  - Device Tree bindings that had not been ACKed by the DT bindings
>    maintainers, one of which should have been merged through the
>    drivers/phy maintainer tree.

Actually, it was reviewed by Rob on 3rd December, but I omitted to
add the attributation he sent.  So that point is false.

> 
>  - A brand new drivers/phy driver that had not been ACKed by the
>    drivers/phy maintainer.
> 
>  - Changes to platform Device Tree that should have been merged through
>    the platform tree.
> 
> Only patches 4/6 and 5/6 should go through the net-next tree, all the
> other patches should have gone through other trees.
> 
> Best regards,
> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
