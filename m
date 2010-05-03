From: mostawesomedude@gmail.com (Corbin Simpson)
Date: Sun, 2 May 2010 18:32:44 -0700
Subject: Updating Didj for Modern Times
Message-ID: <k2ve7bd23c31005021832xf3d90bd8q34dfbc2f8c4ef927@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

So I appear to be the kernel guy in charge of the Leapfrog Didj code.
It's a straightforward device based on the MagicEyes Pollux SoC. We
have datasheets, breakouts, and a kernel tree based on v2.6.20 that
builds, compiles, runs, and even brings up the proprietary userland.

v2.6.20 is old. Jesus-and-dinosaurs old. I've been working on
forwardporting stuff slowly but surely, see
http://git.kernel.org/?p=linux/kernel/git/csimpson/linux-2.6.git;a=summary
for the gory details. However, I've run into a fair number of
problems, and frankly I'm not used to digging this deep into kernel
internals.

~ Fragile code. Everything, from the MMU setup to the serial init, has
little changes all over it, some of which are related and some aren't.
I've slowly been splitting out patches, but some of them have been
absolutely defiant in their resistance, and it feels like the smallest
change results in something that hangs after decompress. It doesn't
help that the LF guys made most of this code work by peppering the
tree with #ifdef CONFIG_ARCH_LF1000.

~ Custom drivers, lots of them. ADC, DMA engine, effectively the
framebuffer and LCD, 3D accelerator (we have docs and no NDA! Whoo!),
I2S, SPI, & I2C busses, iDCT, and a PWM. All custom, not using
standard interfaces. Not even the framebuffer. :C To their credit,
they backported just UBI, more or less intact, and that's it.

Any hints would be highly appreciated. I'm largely stymied as to how to proceed.

~ C.

-- 
When the facts change, I change my mind. What do you do, sir? ~ Keynes

Corbin Simpson
<MostAwesomeDude@gmail.com>
