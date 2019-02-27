Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B89AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:17:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6F9218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OVS0B0G8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6F9218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:
	In-reply-to:Subject:To:From:References:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ttCg/NhSa0dh9+7wyeDccqdCJquFU2MNi+k00IG8eSA=; b=OVS0B0G8QeI4wpiPFWnvjU5Enx
	SmqO6p/gN0hKtvAK6oB6pdWYuUZztMgHO8V2ER02V7K2zUhIMNHFaQ1HtBYP3WPI5KP9ziUiUf5Aq
	Mzb4gtB+0IKetdpchWekG7pUtjP08vkIa5A589ycoFeAwCPStqiJyEkchA/+guO9W4mDGzrZv4Yfe
	nW2sXhNq992e6JrreYoMj8UyRKNJ9gyrLOKW0JnKU8DLxzW1xeStkl2ixYPj+mPSaCIvy75zYz3EV
	R1ebpwfmC7DiQ9Qe6M/uRmv9umcLBcPIf7qhpIHj5btprgNxj/LLwNohIXyAFs8qwJZGcjYZL7tB3
	5CUoBCdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyrae-0004G6-St; Wed, 27 Feb 2019 05:17:08 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyraZ-0004Ex-Aq
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 05:17:06 +0000
Received: from tarshish (unknown [10.0.8.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id BD73D4403CA;
 Wed, 27 Feb 2019 07:16:54 +0200 (IST)
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-5-miquel.raynal@bootlin.com> <87tvgt7o0q.fsf@tarshish>
 <20190225115826.5bc17f6d@xps13>
 <20190225121519.2quhgqcf24rutqn4@sapphire.tkos.co.il>
 <20190225130502.om6y5q7cbe35fbyw@shell.armlinux.org.uk>
User-agent: mu4e 1.0; emacs 26.1
From: Baruch Siach <baruch@tkos.co.il>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 4/5] arm64: dts: marvell: armada-8040-clearfog: Drop
 non-existent SATA port
In-reply-to: <20190225130502.om6y5q7cbe35fbyw@shell.armlinux.org.uk>
Date: Wed, 27 Feb 2019 07:16:54 +0200
Message-ID: <87woll6cah.fsf@tarshish>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_211703_875139_F80CE3BF 
X-CRM114-Status: GOOD (  23.87  )
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
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jon Nettleton <jon@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>,
 Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-ide@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Russell,

On Mon, Feb 25 2019, Russell King wrote:
> On Mon, Feb 25, 2019 at 02:15:19PM +0200, Baruch Siach wrote:
>> On Mon, Feb 25, 2019 at 11:58:26AM +0100, Miquel Raynal wrote:
>> > Baruch Siach <baruch@tkos.co.il> wrote on Sun, 24 Feb 2019 07:29:09
>> > +0200:
>> >
>> > > On Fri, Feb 22 2019, Miquel Raynal wrote:
>> > > > There is no CP110 SATA port available on the 8040 Clearfog A8k, SATA
>> > > > may be used thanks to a mPCIe -> SATA extension board only. Hence, the
>> > > > cp1_sata0 node must be removed from the device tree.
>> > >
>> > > Not true. You can use the mini PCIe serdes as SATA directly if you
>> > > configure it as such. You only need to invert the serdes Rx pair
>> > > polarity. This is the default configuration for the Clearfog GT-8K CON3
>> > > mini-PCIe slot (CP1, lane #0) in current mainline U-Boot. I verified
>> > > that this setup works on Clearfog GT-8K.
>> > >
>> > > This patch would break mini PCIe direct SATA.
>> >
>> > Thanks for explaining, I am a little bit surprised that it actually
>> > uses the SATA host IP on CP110 but fine. So can you tell me which SATA
>> > port is used in this case? Because I will have to update the DT
>> > representation along with the CP110 changes.
>>
>> According to the cp110_comphy_phy_mux_data[] array in U-Boot
>> drivers/phy/marvell/comphy_cp110.c, serdes 0 of CP110 can only be SATA1 (i.e.
>> the second port; first is SATA0).
>
> Adding folk from SolidRun...
>
> Why are the mPCIe connectors configured by default for mSATA cards?

This is sort of capability demonstration.

> This sounds like it's going to cause confusion.  The published
> specification for the board at:
>
> https://developer.solid-run.com/products/clearfog-gt-8k/
>
> states that the board has "3 x mPCIe (USB 2.0 + PCIe)" and makes no
> mention of mSATA.
>
> mSATA is not compatible with mPCIe - mSATA cards expect the serdes
> lanes to be connected to a SATA interface, mPCIe cards expect a PCIe
> controller at the other end of the serdes lanes.
>
> Given that there is a lot of confusion about mSATA vs mPCIe out there,
> (caused by both being the same physical form factor and fitting into
> the same socket, yet being electrically different) I think it's
> important to have a coherent story on these connectors everywhere.
>
> Maybe we need a way to have these connectors configurable by the end
> user?

The user can set the PCIe/SATA serdes configuration in U-Boot CP110
comphy nodes.

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
