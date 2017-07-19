From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Wed, 19 Jul 2017 11:12:51 +0200
Subject: [v4.13 regression] ARM: zImage: Fix stack overflow in
 merge_fdt_bootargs()
In-Reply-To: <20170719084727.lhjkr4kccc2xjw7r@earth>
References: <257f11e3b0010a3a44c28b34a048278f7b960f3b.1500238579.git.rask@formelder.dk>
 <20170719081536.GA17727@amd>
 <20170719084727.lhjkr4kccc2xjw7r@earth>
Message-ID: <20170719091251.3jajjzf5qoc6le3h@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 19, 2017 at 10:47:27AM +0200, Sebastian Reichel wrote:
> On Wed, Jul 19, 2017 at 10:15:36AM +0200, Pavel Machek wrote:
> > > This function is called very early on from head.S and currently sets up a
> > > stack frame of more than 1024 bytes:
> > > 
> > > atags_to_fdt.c: In function ?merge_fdt_bootargs?:
> > > atags_to_fdt.c:98:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > > 
> > > This causes a crash and failure to boot with some combinations of kernel
> > > version, gcc version and dtb, such as kernel version 4.1-rc1 of 4.1.0,
> > > gcc version 5.4.1 20161019 (Debian 5.4.1-3) and tegra20-trimslice.dtb.
> > 
> > > 
> > > Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
> > > Fixes: d0f34a11ddab ("ARM: 7437/1: zImage: Allow DTB command line concatenation with ATAG_CMDLINE")
> > 
> > I tested that it does not break boot on N900. I hoped that it would
> > fix boot on N950 (but no luck there so far).
> > 
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> > 
> > AFAICT this is regression in v4.13-rc1. Thus it is quite surprising
> > that there are no comments here.
> 
> No, it's not. I definitely saw the warning before (and see it now)
> and images can be booted on all of the phones I'm working on (i.e.
> N900, N950, Droid 4).
> 
> Anyawys thanks for fixing this properly. I will add the patch to my
> dev branch and give it a test during the day.

It does work for me.

Tested-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170719/1355cdb6/attachment.sig>
