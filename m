From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 28 Feb 2012 00:10:38 +0100
Subject: [PATCH v3] ARM: LPC32xx: Ethernet support
In-Reply-To: <4F4BFDD2.8060007@antcom.de>
References: <1330364762-23203-1-git-send-email-stigge@antcom.de>
 <20120227180814.GB21386@pengutronix.de> <4F4BFDD2.8060007@antcom.de>
Message-ID: <083DF309106F364B939360100EC290F81F365B2B2A@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> This patch adds ethernet support to the LPC32xx ARM architecture.
>>> The actual driver in drivers/net is contained in a separate
>>> patch.
>>> 
>>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>>> 
>>> ---
>> 
>> Please add below this dashed line what changed since the last
>> version. This makes reviewing easier. 
>
>OK, will do next time.
>
>For the driver, some style fixes were applied, and the cmdline
>"ethaddr" was removed, relying on the bootloader to set it correctly
> (and it actually does, it actually needs to prepare TFTP booting).

I'm not sure I'd trust the bootloader to always set the MAC address
in hardware prior to calling the kernel. A lot of u-boot MAC drivers,
including the 32x0's, only set the MAC address on the call to
eth_init(), which is only called when the network interface is used.
If you do a MTD based kernel boot, the MAC address will probably be
invalid if you try to do a NFS mount for the filesystem.

>The platform-support patch just adjusted to the small driver change:
>driver name adjustment ("lpc-eth") for consistency.
>
>Roland
