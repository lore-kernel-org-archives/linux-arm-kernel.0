From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 31 Mar 2011 10:26:01 +0200
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <AANLkTikf63wTfM1z2cpV+GuK28y1wrT7UWvw4TanBj4R@mail.gmail.com>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330073651.GR7285@pengutronix.de>
	<AANLkTikf63wTfM1z2cpV+GuK28y1wrT7UWvw4TanBj4R@mail.gmail.com>
Message-ID: <20110331082601.GV7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 05:23:12PM -0500, Matt Sealey wrote:
> Sascha,
> 
> Freescale has a driver. We have a driver since we're under NDA and
> have the source.
> 
> If you want it and want to boot Ubuntu on a Smartbook or Smarttop, we
> can give you a package that will run on our kernel and load the GPU
> module if present (we actually ship it as a module built inside the
> kernel, it's not external and it's dual BSD/GPL licensed). Regardless
> of where you've not seen it, it does exist. I want this code in there
> - on the basis that we have a consumer product that ships and needs
> it, and this is going to be a dependency for OpenGL, OpenVG, and
> things on top like Flash which may depend on that.
> 
> I dunno if I am in the "path" for this since I have the source code
> for the driver for the kernel (it's on opensource.freescale.com/git in
> drivers/mxc/amd-gpu somewhere after the 09.12 BSP ) and for the
> userspace (it's NDA code) I don't believe there's any hard and fast
> policy that says the kernel cannot have drivers referenced that are
> not part of the mainline stack, otherwise no external module using USB
> or any other pluggable module built externally, which Linus does not
> disapprove of, would never be allowed to build against the kernel.

With USB there is a clear API defined and exported from the kernel to
userspace. This API can be used from source and yes, also from closed
source drivers.
The FSL gpu driver is different, its API has been defined for only one
closed source driver. There is no way of making use of it without closed
source. There is no way for kernel maintainers to test this API without
closed source. There is also no way to ever change this API without
having the source available.
No, there is no place for this kind of stub drivers in the kernel.
Otherwise we would also have nvidia binary driver stubs.

In any way we can delay this until there is some code using it.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
