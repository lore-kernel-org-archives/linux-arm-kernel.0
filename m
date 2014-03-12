From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Mar 2014 11:53:58 -0500
Subject: [PATCH] arm: boot: dts: build keystone devicetree blob
In-Reply-To: <53208CDD.7030106@ti.com>
References: <1394639330-1288-1-git-send-email-balbi@ti.com>
 <53208CDD.7030106@ti.com>
Message-ID: <20140312165358.GE919@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 12:35:41AM +0800, Santosh Shilimkar wrote:
> On Wednesday 12 March 2014 11:48 PM, Felipe Balbi wrote:
> > Currently, even when building keystone only
> > kernel builds, DTB won't get build because
> > we lack a Makefile rule to get it compiled.
> > 
> > This patch adds that rule so mainline kernel
> > users have a chance to use up-to-date DTB on
> > keystone 2 platforms.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >
> We have been building dtbs with explicit command
> instead of dtbs since it was just one dtb so far
> supported. Was planning to add the rule once more
> boards get added. Now with Lamarr and Edision in
> for next merge window, will do that post 3.15-rc1.
> 
> > note that I just tried this on top of linux-next
> > (commit 69d5cdda16b3c9767b82d80b07edb9bb056448e3)
> > and, even though dtb builds fine, I still couldn't
> > get keystone_defconfig uImage to boot fine.
> > 
> > It's probably my LOADADDR which is wrong.
> > 
> > Santosh, what's the LOADADDR I should be using
> > for keystone boots ?
> >
> LOADADDR is same 0x80008000. You might have missed

tried that, didn't help.

> to configure the environment u-boot variable to
> disable higher address space switch.
> 'setenv mem_lpae 0'. Also ensure to update

hmm, that might do it. Will try after upgrading u-boot to latest
release.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/1469d685/attachment.sig>
