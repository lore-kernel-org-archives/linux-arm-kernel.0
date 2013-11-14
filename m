From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 14 Nov 2013 12:16:22 -0700
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <52851DC8.203@wwwdotorg.org>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
 <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
 <528275B7.6050209@wwwdotorg.org>
 <20131112193012.GR10335@titan.lakedaemon.net>
 <52828C77.20001@wwwdotorg.org>
 <20131114162859.GX10335@titan.lakedaemon.net>
 <52851DC8.203@wwwdotorg.org>
Message-ID: <20131114191622.GC21549@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 12:00:24PM -0700, Stephen Warren wrote:

> I don't think a distro should need to know the DTB filename at all.
> Rather, the/a bootloader should know which platform it's running on, and
> provide a variable/... to the boot script/... that defines the DTB
> filename. That would completely remove all the knowledge of DTB
> filenames from distros.

At some point the distro has to install a dtb into some cannonical
place so the bootloader can find it..

Are you thinking that distros will have to ship a /boot/dtbs/*.dtb
with every dtb from the kernel build?

What happens when you install two different versions of the kernel?

What about boot schemes that can load a kernel version dependent dtb?

I've said this before - I really think the kernel community will do
itself a big favor if it encourages boot schemes that can handle a
kernel version dependent dtb, rather that design schemes that
absolutely can't allow for that.

Jason
