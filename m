From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Oct 2013 10:17:33 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131024080624.GV30088@pengutronix.de>
References: <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023180108.GA23728@roeck-us.net>
 <20131023182502.GC32563@obsidianresearch.com>
 <20131023183041.GH5208@netboy>
 <20131023185435.GD32563@obsidianresearch.com>
 <20131024080624.GV30088@pengutronix.de>
Message-ID: <20131024081733.GG9403@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 10:06:24AM +0200, Sascha Hauer wrote:
> On Wed, Oct 23, 2013 at 12:54:35PM -0600, Jason Gunthorpe wrote:
> > On Wed, Oct 23, 2013 at 08:30:42PM +0200, Richard Cochran wrote:
> > > On Wed, Oct 23, 2013 at 12:25:02PM -0600, Jason Gunthorpe wrote:
> > 
> > > > On ARM the package of 'stuff' can very reasonably include dtb. Distro
> > > > scripts can package modules+DTB+vmlinuz into something the bootloader
> > > > can understand. (The next pain point will be to standardize that)
> > > > 
> > > > The DTB doesn't have to be 'outside' the distro/kernel to give users a
> > > > seamless upgrade experience.
> > > 
> > > How can a distro possibly provide me a DTB?
> > > 
> > > They don't know what hardware I am using. Only I know that.
> > 
> > I'm not sure what you are asking? Treat DTBs like kernel drivers. If
> > you make hardware and you want distros to run on it, you have to
> > provide the DTB for that hardware to mainline+distros.
> > 
> > Remember, there are two ways to view DTB:
> >   a) It comes from the firmware and you have to live with whatever
> >      crap the firmware does
> >   b) It comes from the kernel, must match the kernel, and we don't
> >      have to tolerate crap in the DTB.
> 
> c) It comes from the firmware and is at least good enough to bring up a
>    kernel to install a better devicetree.

That's an interesting new view. And I think that makes a lot of sense
because it matches the product cycle pretty well. Typically I wouldn't
expect an upstream kernel to be fully featured when first shipped in a
product, for all the known reasons, but it should be possible to come
up with stable bindings good enough to perhaps boot to a command-line
prompt and have some way of accessing other files (network, block
device, ...).

Then again you could argue that the bootloader should be able to update
itself (and the DTB while at it).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/bf466b98/attachment.sig>
