Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E9AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:39:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152DE21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CQzFKTKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152DE21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fay3efnYSlK1U4IUbG1/F4pArBbvo2inHgj1WgYqYDw=; b=CQzFKTKYY2BTbc
	V4d7ChK27Wpr+sv5bfdQBxNEq79lxp5BqgMkRInOHBO3ah0/WHF5jnrXYaWs3QNQW89mZhs/aQULB
	ypFI8fjddw+9hpqUAa4NsusYBJfkX5f1xMj/gQ4F4ufX/98wmwiOwuxPGJu5IPDvleHmK9nA4B6c/
	MRRlQP0cJBAF/OQboMDvoQ6437iMQ2wueFwCB7mdWZERlzcYmEdEjTA3j9Oz3BKdk4XXInZkgtK8t
	5U33DF4wX8cYU3ejpAjlUvUjR2CBkzXCUJkwTCqNK5JRd0h3TX/T5q/YeHXtUVczmBGWpObY8pIBB
	45zF+RMGnOMzMuYaSwAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm01c-000542-42; Tue, 22 Jan 2019 17:39:48 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm01Y-00053e-TG
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 17:39:46 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9601020758; Tue, 22 Jan 2019 18:39:41 +0100 (CET)
Received: from windsurf (pv7105-0562400153.pck.nerim.net [62.212.110.213])
 by mail.bootlin.com (Postfix) with ESMTPSA id 022BE206A6;
 Tue, 22 Jan 2019 18:39:39 +0100 (CET)
Date: Tue, 22 Jan 2019 18:38:33 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY
 bindings
Message-ID: <20190122183833.40077d7a@windsurf>
In-Reply-To: <20190121112336.23489-7-miquel.raynal@bootlin.com>
References: <20190121112336.23489-1-miquel.raynal@bootlin.com>
 <20190121112336.23489-7-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_093945_094737_D35AE02C 
X-CRM114-Status: GOOD (  13.42  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Mon, 21 Jan 2019 12:23:32 +0100, Miquel Raynal wrote:

> +- compatible: Should be one of:
> +	      * "marvell,a3700-utmi-host-phy" for the PHY connected to
> +	        the USB2 host-only controller.
> +	      * "marvell,a3700-utmi-otg-phy" for the PHY connected to
> +	        the USB3 and USB2 OTG capable controller.

Do we really need different compatible strings for those ? I assume the
IP block is exactly the same for the two PHYs, right ? If so, we should
use the same compatible string.

Didn't we discuss that we can lookup from the PHY whether the USB
controller it is connected to is in host mode or otg mode ?

> +Example:
> +
> +	usb2_utmi_host_phy: phy@5f000 {
> +		compatible = "marvell,armada-3700-utmi-host-phy";
> +		reg = <0x5f000 0x800>;
> +		marvell,usb-misc-reg = <&usb2_syscon>;
> +		#phy-cells = <0>;
> +	};
> +
> +	usb2_syscon: system-controller@5f800 {
> +		compatible = "marvell,usb2-host-miscellaneous", "syscon";
> +		reg = <0x5f800 0x800>;
> +	};

Those registers are contiguous to the register range of the PHY itself.
What was the criteria used to decide that we need two separate DT nodes
for these ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
