Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AA9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:25:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784AC2083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dYk/8TXL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="By1OrJXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784AC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MfiIjyogdAfSe/HN2AIkRXZU8irYyvxM4r+j84OJTns=; b=dYk/8TXLH/zf6e
	FqXcD2b1xvNlYx0xR7JHUrPtiHCbfxtBkUOTdgqcQeoRHR+yzFZL6pvxzuEfe53fBLgAjqYf73+zH
	h/nCbDdTT4NlejZ3Cj66o3kWzn+7N7fZnejOWzzO8nMUfbzldBSpd6iZR4YG969+WJ+LM3fsQD/xf
	6+N2Tfbd+ffrHTm7bBWJCGOgv6+9kEvcUkLmgTjOHSGmQYkPiQos4GiuJb9U2DCwuVBSi1+rD7UZl
	M8w2j0zbvXNdsBfoV+6uYdfIYly+q9A3hY3BHkdQ4EN66bXBjqw+TOzsGV9FqRFPO6SQsI4xN0ZZm
	asdU+JqTTXpaihjE2JiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqDo-0005RW-D0; Thu, 21 Feb 2019 15:25:12 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqDk-0004Yx-9M
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:25:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
 Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jVJv1+dguLI4tKg6gHtO7nLWMeTo9l6YXa8ZnZJcLKI=; b=By1OrJXAWObK/P6SU4eAh6l4b
 t5u06wDkMxz6hHnLtGNwYECISlBCR6Ms9epoJ+iANn8iD29PL8s32tAf2XVr2GCgiC+2X8wdXgFaa
 uUBtXF/Yjwf4Etngu+6yI8n01seu3zfqL8d/z2LnWxtzm5nulapMovNX038lslXmMrUxdmsaHbgjO
 hKVuEHvdDaamcHKya3Em5Dkx3si20g61LRMajH8L28ARvvz4PEx7jKUnBIjZrTPV5ODqjq6jjsk8e
 IxwobK5IMSkfUfHVfZXtcCk6kKdvbf7E2ml79phQZZ6c9eGWD78t+0jkdxPGJNo6Ct+l+O7G/Dn0A
 DUVtxbNkw==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51324)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gwqDd-0003Tl-1O; Thu, 21 Feb 2019 15:25:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gwqDb-0001RJ-FO; Thu, 21 Feb 2019 15:24:59 +0000
Date: Thu, 21 Feb 2019 15:24:59 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: [BUG] vf610-zii-dev-rev-b SPI fails at boot
Message-ID: <20190221152459.axrjce7yqkjmedgl@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_072508_334859_AADA2289 
X-CRM114-Status: UNSURE (   7.48  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While booting 4.20 on the ZII development revision B board, I notice 
this in the kernel logs:

spi spi0.1: setup: unsupported mode bits 4
spi_gpio spi0: can't setup spi0.1, status -22
spi_master spi0: spi_device register error /spi0/at93c46d@1
spi_master spi0: Failed to create SPI device for /spi0/at93c46d@1

This is for the at93c46d@1 device attached to spi-gpio (see
arch/arm/boot/dts/vf610-zii-dev-rev-b.dts around line 330).  This
is declared with "spi-cs-high;" in DT.  It appears to be complaining
about the SPI_CS_HIGH flag.

It appears this warning comes from drivers/spi/spi.c around lines
2828-2847 due to:

	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);

and it looks like spi-gpio sets:

	master->mode_bits = SPI_3WIRE | SPI_CPHA | SPI_CPOL;

but then goes on to set:

	spi_gpio->bitbang.flags = SPI_CS_HIGH;

However, this is ignored by bitbang if master->mode_bits has already
been set:

	if (!master->mode_bits)
		master->mode_bits = SPI_CPOL | SPI_CPHA | bitbang->flags;

It looks like this commit introduced for v4.19 broke the driver:

commit 4b859db2c60692560afbfef1b030d0ddef57b7ee
Author: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat Jul 28 10:19:14 2018 +0200

by setting master->mode_bits - prior to this, bitbang would have set
the mode bits itself.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
