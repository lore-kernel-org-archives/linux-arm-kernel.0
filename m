From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 19 Sep 2011 11:22:28 -0400 (EDT)
Subject: [PATCH] ARM: supply a DTB file to be appended
In-Reply-To: <CACRpkdZ+s_y=4VJuz5WetaU1tUFF-f6g38bpy6TSRjt9Q_VgLg@mail.gmail.com>
References: <1315476884-28470-1-git-send-email-linus.walleij@stericsson.com>
	<CACRpkdZ+s_y=4VJuz5WetaU1tUFF-f6g38bpy6TSRjt9Q_VgLg@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1109191118400.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Sep 2011, Linus Walleij wrote:

> On Thu, Sep 8, 2011 at 12:14 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
> 
> > This makes it easy to script the kernel build with
> > different device trees, and it also vastly simplifies
> > building uImages since "make uImage" will now pick
> > up the devcie tree and include it in the final image
> > as part of the build process.
> 
> A clarification here on what it actually simplifies.
> 
> make zImage
> cat my.dtb >> arch/arm/boot/zImage
> make uImage
> 
> Does *not* work.

You must have been confused by what this patch fixes:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7016/1

Some confusion on my part made me create a similar patch and send it to 
RMK, but the issue being fixed is the same.

So yes, the above now *does* work.


Nicolas
