From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 23 Oct 2013 11:01:08 -0700
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023172955.GA17145@obsidianresearch.com>
References: <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
Message-ID: <20131023180108.GA23728@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 11:29:55AM -0600, Jason Gunthorpe wrote:
> 
> As far as I can see, all stable DTB gets you is the ability to flash
> the DTB into the firmware and never change it. Who does that actually
> help?
> 
Not me. We want to be able to run the same kernel on different hardware,
so we would not want to tie the dtb with the kernel image, but
the ability to update the dtb on a system when updating the kernel
is essential. There is no requirement to be backwards compatible.
Sure, it is nice to have, and in most cases the dtb _will_ be backward
compatible with newer kernels, but it is not a requirement.

For us, one of the advantages of dtb is that it is more flexible
and easier to update than, say, DSDT, which tends to be tied to the BIOS
and is much more difficult to update in the field.

That doesn't mean that one should go ahead and change DT bindings at a whim
without good reason. But I like the approach used for sysfs attributes much
over the notion of "Thou Shalt Not Change Anything" used for DT bindings.
sysfs attributes don't change at a whim either, as there is real impact
if they do, but that doesn't mean they are completely off limits either
(nor does the use of sysfs bindings residing in the 'ABI/testing' directory
result in kernel warnings or in tainted kernels).

Guenter
