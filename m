From: slash.tmp@free.fr (Mason)
Date: Thu, 26 Nov 2015 18:10:06 +0100
Subject: ARCH_MULTIPLATFORM + ARM_APPENDED_DTB + custom boot-loader
In-Reply-To: <565738F7.1060204@free.fr>
References: <565738F7.1060204@free.fr>
Message-ID: <56573CEE.10101@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/2015 17:53, Mason wrote:

> I'm using an ARCH_MULTIPLATFORM kernel with an appended DTB.
> I make a uImage out of this zImage+DTB.
> On my board, U-Boot passes control to Linux, which boots correctly.
> 
> But when I replace U-Boot with a custom boot-loader, Linux tries
> to boot some kind of "Generic DT based system" rather than the DT
> I appended.
> 
> In fact, my setup code is:
> 
> static const char *const tango_dt_compat[] = { "sigma,tango4", NULL };
> DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
> 	.dt_compat	= tango_dt_compat,
> 	.l2c_aux_mask	= ~0,
> 	.l2c_write_sec	= tango_l2c_write,
> MACHINE_END
> 
> 
> When I boot with U-Boot, in the early stage, the kernel prints
> [    0.000000] Machine model: Sigma Designs SMP8758 Vantage-1172 Rev E1
> (that's my model property)
> 
> But when I boot with the custom boot-loader, it just prints
> [    0.000000] Machine: Sigma Tango DT
> (and fails quickly since there are no clocks)

I was working off incorrect assumptions.
The custom boot-loader was given an Image (not a uImage) and the DT
was probably not appended to the Image.

Question: can a DT be appended to an Image, or does it have to be
appended to a zImage? Can a zImage be uncompressed or compressed
with a null compressor?

Regards.
