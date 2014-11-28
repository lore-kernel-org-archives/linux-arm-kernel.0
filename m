From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Nov 2014 14:50:35 +0000
Subject: [PATCH v3 3/5] arm64: dts: Add support for Spreadtrum SC9836 SoC
 in dts and Makefile
In-Reply-To: <20141128144412.GG7144@arm.com>
References: <Sharkl64-v3>
 <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1416917818-10506-4-git-send-email-chunyan.zhang@spreadtrum.com>
 <20141127115042.GE857@leverpostej>
 <20141127121214.GF11511@e104818-lin.cambridge.arm.com>
 <20141127134309.GJ857@leverpostej>
 <20141128142913.GB5393@localhost>
 <20141128143532.GI25883@leverpostej>
 <20141128144412.GG7144@arm.com>
Message-ID: <20141128145035.GO7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 02:44:12PM +0000, Will Deacon wrote:
> On Fri, Nov 28, 2014 at 02:35:32PM +0000, Mark Rutland wrote:

> > Probably too rude, given it doesn't WARN() the user.

> We override broken hardware ID registers all the time in device-tree without
> dumping stack. Why is this any different?

I do tend to agree that a WARN() is excessive but given the amount of
pushback on using this property on ARMv8 systems saying something would
be nice, though...

> > We should be extremely loud if we see the clock-frequency property on an
> > arm64 system. Whether or not we should ignore the property is another
> > matter.

> I don't really see the point in ignoring it. We will see broken hardware
> [1] and this is just preventing ourselves from working around it. I'd much
> rather have arch-timers with a "clock-frequence" property than have some
> other timer instead because the kernel driver is being stubborn.

...it is likely that even if there is a warning we'll end up in this
situation.  If the kernel doesn't complain at all it seems totally
reasonable for people to use the feature, but just refusing to allow it
to be used at all doesn't seem like it's actually helping things.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/9cca4898/attachment.sig>
