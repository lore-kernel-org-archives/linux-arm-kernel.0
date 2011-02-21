From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Feb 2011 13:13:25 +0000
Subject: Question About Linux Memory Mapping
In-Reply-To: <AANLkTikdPrjHRFc6bD1VsN3MCZkKD0dVSNq1ijgp7qz9@mail.gmail.com>
References: <201102192122.53746.marek.vasut@gmail.com>
	<919555.44803.qm@web161702.mail.bf1.yahoo.com>
	<AANLkTikdPrjHRFc6bD1VsN3MCZkKD0dVSNq1ijgp7qz9@mail.gmail.com>
Message-ID: <20110221131325.GP14495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 01:13:16PM +0100, Drasko DRASKOVIC wrote:
> Thanks for your answers.
> 
> I can see now that "mem" parameter is parsed in
> arch/arm/kernel/setup.c, as Nicolas underlined. However, in my case
> early_mem() is never called during the Linux boot.
> 
> Does anybody have an idea why ?

Maybe the command line setting is being ignored by your boot loader
and the one built-in to the kernel is being used?

Maybe your kernel is configured to ignore the command line supplied
by your boot loader?

Maybe you're setting it in the kernel build but not realising that
the boot loader passed one is being used instead?

If you provide the kernel configuration and the kernel boot messages
for the last kernel you tried, it may be possible to work out what's
going on.
