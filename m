Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5FEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:24:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CAC72147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xd0ozIGH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0Pd6bXRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAC72147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9sSsOnF1zqE/pkXybnYIvklMzU5NEJ8CVECkzS7zJZ8=; b=Xd0ozIGHyXCLFj
	lrxI6Ahhx/3F0E+2Ep9+E29tmIaEu8/BznVXDyAteQHSHxskmLe8CnOycQmtGgd3CKocj3sv6MAUB
	094xM66neFlHKQZCOe5XSVve0vbjw1hpBFcf9NZtiRG8urd2XKqyJ7nqSCS+1JRoR0mWIh4LaZwf8
	VD2/B9NRxr2bt4ob++XEAg6no/OCmEKR+6RWWKaTk2j7EueZeRxtDTqOpcQrRx8bimGtH6oK7mU01
	Wb7ov4+9XVqBK2s+WEGzNolhW2VGPOE0IQ0vW9C1GMc3R8HiULo80BoWbfGLWjUcSIyRoB7TxbbvH
	AALaeImDVj8ATA/8b1mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8Bp-0002oB-R3; Tue, 19 Feb 2019 16:24:13 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8Bm-0002ng-Tl
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 16:24:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=13rzi5lNUKHbEz97EDZoH4VcN/cIaf8Xoei6CbJTAjw=; b=0Pd6bXRxGOB5oGdA8dhdcYVEM0
 g7Adaef/cgpqDtJEAEpn5e9inCYPOxrQFl+8w/Mr8CO3FcqHEimiLLxylsees7gHnV2dqs3zZpvLt
 SjRzyzENCDCjD3WFMUBSJ9NYKgM8saAPmt0IvVc2u1qao5H+n6xI1vfPlo33F0QLp2fg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gw8Bi-0003iB-1S; Tue, 19 Feb 2019 17:24:06 +0100
Date: Tue, 19 Feb 2019 17:24:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] arch: arm: dts: kirkwood-rd88f6281: Remove disabled
 marvell,dsa reference
Message-ID: <20190219162406.GB13075@lunn.ch>
References: <20190219162225.16453-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190219162225.16453-1-gregory.clement@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_082411_112482_7C8CB042 
X-CRM114-Status: UNSURE (   9.06  )
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
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 Jason Cooper <jason@lakedaemon.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 05:22:25PM +0100, Gregory CLEMENT wrote:
> marvell,dsa properties has been removed from kirkwood-rd88f6281.dtsi
> while cleanuping the dsa binding, but the dsa reference in
> kirkwood-rd88f6281-z0.dts has been missed causing the following errors:
> 
> arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:21.4-16: Warning (reg_format): /dsa/switch@0:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:23.5-15: Warning (reg_format): /dsa/switch@0/port@4:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/kirkwood-rd88f6281-z0.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:20.12-26.5: Warning (avoid_default_addr_size): /dsa/switch@0: Relying on default #address-cells value
> arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:20.12-26.5: Warning (avoid_default_addr_size): /dsa/switch@0: Relying on default #size-cells value
> arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:22.11-25.6: Warning (avoid_default_addr_size): /dsa/switch@0/port@4: Relying on default #address-cells value
> arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts:22.11-25.6: Warning (avoid_default_addr_size): /dsa/switch@0/port@4: Relying on default #size-cells value
> 
> So remove the dsa reference too in order to fix this issue.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Hi Gregory

Sorry about that.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
