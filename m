From: robherring2@gmail.com (Rob Herring)
Date: Tue, 07 Jun 2011 11:54:47 -0500
Subject: [PATCH 3/3] ARM: l2x0: Add OF based initialization
In-Reply-To: <BANLkTi=7rHjKV=+hNKzEHvZMeDPwknOWtg@mail.gmail.com>
References: <1307456541-11026-1-git-send-email-robherring2@gmail.com>	<1307456541-11026-4-git-send-email-robherring2@gmail.com>
	<BANLkTi=7rHjKV=+hNKzEHvZMeDPwknOWtg@mail.gmail.com>
Message-ID: <4DEE57D7.1030704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On 06/07/2011 11:20 AM, Olof Johansson wrote:
> On Tue, Jun 7, 2011 at 7:22 AM, Rob Herring<robherring2@gmail.com>  wrote:
>
>> +- aux-value : Value to set the Auxillary Control register to. Setting masked
>> +  bits is undefined. Default value is 0.
>> +- aux-mask : Mask of bits to preserve in the Auxillary Control register.
>> +  Default value is 0xffffffff.
>
> The device tree should describe the hardware, not the way the linux
> kernel drives the hardware. In the case of the AUX register, it's
> mostly a collection of options that are either turned on or off. I
> don't think they should necessarily be described as an opaque 32-bit
> word, but instead as separate attributes.

Unfortunately, the meaning of the bits depends on the model and there 
doesn't seem to be any commonality or subset of options as to what each 
platform is setting up.

>
> At least the geometry should be specified that way.

That's probably the only part that doesn't get changed. :)

>
> For feature enable bits, it depends on what features should be enabled
> and from the kernel side. I'm not sure that belongs in the device tree
> at all.

I don't think it can be decided what the kernel needs to setup by the 
device tree. The main reason it's needed in the kernel at all is 
probably because the bootloader didn't setup aux_ctrl or set it up 
incorrectly.

Perhaps the magic values should just be left in the platforms and 
continue to be passed into the OF init function:

l2x0_of_init(__u32 aux_val, __u32 aux_mask);

Rob
