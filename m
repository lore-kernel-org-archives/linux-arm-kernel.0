From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Jul 2010 09:47:26 +0100
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <201007211029.29529.david.jander@protonic.nl>
References: <201007211029.29529.david.jander@protonic.nl>
Message-ID: <20100721084726.GC6009@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 10:29:29AM +0200, David Jander wrote:
> General machine initialization like I/O-multiplexing and I/O-pad setup seems 
> to be done twice most of the time: Once in the bootloader (i.e. u-boot), and 
> once in the machine support file in the linux kernel. This seems awfully 
> redundant and error-prone to me. Why is it like this?

I answer your question only once - rather than the number of times you've
asked it in this email.

We do IO mux setup in the kernel for two reasons:

1. we don't trust boot loaders to do the right thing, especially when we
   have a plethora of boot loaders - or even no boot loader - to deal with.

2. on some platforms and SoCs, it's necessary to change the IO mux setup
   at runtime.

> What about fixing bootloaders then?

Forget fixing boot loaders; that's a total and utter lost cause.  Boot
loaders generally don't seem to even be capable of passing a block of
information correctly to the kernel, or even getting one simple value
in a register correct.

Boot loaders really can't be trusted, and the less we rely upon them,
the better.
