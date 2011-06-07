From: olof@lixom.net (Olof Johansson)
Date: Tue, 7 Jun 2011 09:20:30 -0700
Subject: [PATCH 3/3] ARM: l2x0: Add OF based initialization
In-Reply-To: <1307456541-11026-4-git-send-email-robherring2@gmail.com>
References: <1307456541-11026-1-git-send-email-robherring2@gmail.com>
	<1307456541-11026-4-git-send-email-robherring2@gmail.com>
Message-ID: <BANLkTi=7rHjKV=+hNKzEHvZMeDPwknOWtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2011 at 7:22 AM, Rob Herring <robherring2@gmail.com> wrote:

> +- aux-value : Value to set the Auxillary Control register to. Setting masked
> + ?bits is undefined. Default value is 0.
> +- aux-mask : Mask of bits to preserve in the Auxillary Control register.
> + ?Default value is 0xffffffff.

The device tree should describe the hardware, not the way the linux
kernel drives the hardware. In the case of the AUX register, it's
mostly a collection of options that are either turned on or off. I
don't think they should necessarily be described as an opaque 32-bit
word, but instead as separate attributes.

At least the geometry should be specified that way.

For feature enable bits, it depends on what features should be enabled
and from the kernel side. I'm not sure that belongs in the device tree
at all.


-Olof
