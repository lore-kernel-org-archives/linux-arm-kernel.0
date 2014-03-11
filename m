From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 11 Mar 2014 12:09:08 +0100
Subject: [PATCH v3] i2c:at91: Add device tree property to set
 clock-frequency
In-Reply-To: <C7EB5260-2285-4572-9D73-15312BB09F65@jcrosoft.com>
References: <1394511938-28653-1-git-send-email-mark.roszko@gmail.com>
 <C7EB5260-2285-4572-9D73-15312BB09F65@jcrosoft.com>
Message-ID: <20140311110908.GB24766@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Examples :
> > @@ -23,6 +24,7 @@ i2c0: i2c at fff84000 {
> > 	#address-cells = <1>;
> > 	#size-cells = <0>;
> > 	clocks = <&twi0_clk>;
> > +	clock-frequency = <400000>;
> > 
> The bindings is wrong it?s not the bus frequency but the max frequency
> 
> as you describe the bus not the device frequency. And this is this one that limit the bus

It is not wrong, it is since "the beginning" the way i2c bus speeds are
described. It is well known that, in fact, the devices should have a
speed limiting property, yet nobody has sent in patches so far.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/636d36cf/attachment.sig>
