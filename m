From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 17 Feb 2014 10:12:37 +0100
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
Message-ID: <20140217091237.GC2633@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Why is that? From my knowledge, you start with the exact compatible
> > property and hardware compatible entries may follow.
> 
> I think this boils down to if they really are compatible or not. If
> for instance a 16550 port would be compatible with 8250 on a hardware
> level then using them in the order of "16550", "8250" makes sense. In
> this case the r8a7791 i2c is not really strictly based on r8a7790 i2c,
> it is just that r8a7790 has support in the driver. So it's a short cut
> instead of actual hardware compatibility.

I don't get this point. The legacy board code for koelsch and lager both
create a platform_device with "i2c-rcar_gen2", so the cores surely must
be compatible? Maybe the cores are not strictly based on each other, but
compatible, yes, I'd say.

> So far we've dealt with this by updating the driver and only relying
> on the actual SoC name as suffix.

OK, for consistency reasons I will resend.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140217/064932de/attachment.sig>
