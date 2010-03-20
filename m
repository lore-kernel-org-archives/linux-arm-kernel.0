From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 20 Mar 2010 19:25:00 +0100
Subject: [PATCH v2 2/3] ep93xx: added chip revision reading function
In-Reply-To: <56d259a01003201107s758b420bmafa154714a8a8fee@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003201107s758b420bmafa154714a8a8fee@mail.gmail.com>
Message-ID: <20100320182500.GF30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 20, 2010 at 06:07:50PM +0000, Martin Guy wrote:
>   The chip revision is normally placed in the global unsigned int
> "system_rev", which is also reported by /proc/cpuinfo.

No, that's the hardware revision number, which is different from the
chip revision number.

system_rev is also what is exported via /proc/cpuinfo because userland
software may need this information to adjust their runtime behaviour.

>   It normally seems to be set from the atags passed by the bootloader
> but uboot on this platform doesn't provide that, so it remains 0.

And this is exactly why it should be passed down from the bootloader.
Either the bootloader is special to each hardware revision (which is
command practice), or it is able to read the revision number from a
bunch of pull-up/down resistors.

>   The same applies to the very similar variables system_serial_low and
> system_serial_high (which also remain 0 on this u-boot platform).
> Shall we also set these from the hardware on ep93xx during thus giving
> them non-zero values in /proc/cpuinfo too?

If the ep93xx provides a unique serial number, then this could be an
idea. I would still only set it in case it has not been given by the
bootloader though.

Daniel
