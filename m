From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 14 Dec 2015 08:11:03 +0100
Subject: [PATCH/RFC 03/19] ARM: shmobile: gose: add i2c2 bus to device tree
In-Reply-To: <20151214021110.GD13945@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-4-git-send-email-horms+renesas@verge.net.au>
 <566AB2A5.4090105@cogentembedded.com>
 <20151214021110.GD13945@verge.net.au>
Message-ID: <20151214071103.GC1516@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > >+	eeprom at 50 {
> > >+		compatible = "renesas,24c02";
> > 
> >    This is not a valid value -- the Renesas chip model is different from 24c02.
> 
> I copied this value from r8a7791.dtsi.
> 
> Looking at the schematic for gose (v100), koelsch (rev024) and porter (v300)
> I see the following "R1EX24002ATAS0G#U0". Shall we update r8a7791 and
> this patch to "renesas,24002" or leave things as is?

I wouldn't like to update the at24 driver with all namings from all
vendors for chips which in large cases are simple 24c02 devices.

So, if Sergei insists on the change, I'd propose

	compatible = "renesas,24002", "24c02";

to keep things sane.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151214/1203594e/attachment.sig>
