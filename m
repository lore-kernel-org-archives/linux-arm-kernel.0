From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Mar 2010 19:48:58 +0000
Subject: secondary processor initialization
In-Reply-To: <4B96A278.4060300@codeaurora.org>
References: <4B96A278.4060300@codeaurora.org>
Message-ID: <20100309194858.GF17251@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 09, 2010 at 11:33:12AM -0800, Steve Muckle wrote:
> We are adding support for a dual core Scorpion target. The second core
> will require some amount of initialization as well. If we take the
> second core out of reset directly into the kernel, we would have to put
> this initialization in the kernel.

Although we leave the secondary boot code completely up to the board,
we have to date no code in the kernel to deal with bringing a core out
of reset.

We assume that the secondary CPUs are being taken care of by the boot
loader, and we have to poke the address of the secondary CPU
initialization function to some register or memory location and signal
the boot loader.

> Another option is having the secondary CPU(s) execute a portion of the
> bootloader and come in through the main kernel entrypoint. This
> simplifies things but would mean having to put a hook very early in the
> primary boot path, compiled if SMP is configured, which checks the MPIDR
> and reroutes secondary CPUs.

I believe this is what everyone does.
