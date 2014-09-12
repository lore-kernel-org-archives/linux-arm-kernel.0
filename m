From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Sep 2014 10:33:48 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <9935938.eKOCvCAtLt@fb07-iapwap2>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <1591383.Xdy91rktuP@fb07-iapwap2> <20140911145421.GE5149@katana>
 <9935938.eKOCvCAtLt@fb07-iapwap2>
Message-ID: <20140912083348.GA1289@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Why do you want DT to be involved at all?
> 
> Imagine a device which supports both, slave or master mode. The driver needs 
> to know in which mode it should operate. This cannot be hard coded, because on 
> different boards, different modes can be used.

Okay, it sounds weird to me that a device is not able to switch between
master and slave, but if you say so. Also, solving this issue would also
handle potential weird IP blocks which can be slave only, right?

What if you use two different adapter drivers or compatibles? One for
master-mode, one for slave-mode (slave could leave algo->master_xfer
empty, so the slave mode driver cannot send packets). I'm brainstorming
here, so while it should work IMO I will probably need a second thought.

So, in the DT you would have a block registering the I2C slave core
which binds to a simple driver providing reg_slave/unreg_slave and
pass on the slave-event. Then you could instantiate slave clients as
said before.

Maybe we need a real world example?

> The point is, that if we define a dt binding for master device on slave 
> adapters it will be there forever. So even if it makes no sense for the 
> example eeprom simulator (or even our embedded controller), it may make sense 
> for other or future devices.

I don't know what you mean here. Again, an example might help?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/8a64a17c/attachment.sig>
