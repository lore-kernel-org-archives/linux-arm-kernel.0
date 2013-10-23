From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 23 Oct 2013 12:54:35 -0600
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023183041.GH5208@netboy>
References: <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023180108.GA23728@roeck-us.net>
 <20131023182502.GC32563@obsidianresearch.com>
 <20131023183041.GH5208@netboy>
Message-ID: <20131023185435.GD32563@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 08:30:42PM +0200, Richard Cochran wrote:
> On Wed, Oct 23, 2013 at 12:25:02PM -0600, Jason Gunthorpe wrote:

> > On ARM the package of 'stuff' can very reasonably include dtb. Distro
> > scripts can package modules+DTB+vmlinuz into something the bootloader
> > can understand. (The next pain point will be to standardize that)
> > 
> > The DTB doesn't have to be 'outside' the distro/kernel to give users a
> > seamless upgrade experience.
> 
> How can a distro possibly provide me a DTB?
> 
> They don't know what hardware I am using. Only I know that.

I'm not sure what you are asking? Treat DTBs like kernel drivers. If
you make hardware and you want distros to run on it, you have to
provide the DTB for that hardware to mainline+distros.

Remember, there are two ways to view DTB:
  a) It comes from the firmware and you have to live with whatever
     crap the firmware does
  b) It comes from the kernel, must match the kernel, and we don't
     have to tolerate crap in the DTB.

Both make sense, but, IMHO, minimizing the occurrence of 'a' is a
good goal...

Jason
