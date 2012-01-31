From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 31 Jan 2012 11:46:59 +0000
Subject: [PATCH] ARM: devicetree: Add .dtb files to
 arch/arm/boot/.gitignore
In-Reply-To: <20120131032022.GC24681@S2101-09.ap.freescale.net>
References: <1327945574-7977-1-git-send-email-dave.martin@linaro.org>
 <20120131032022.GC24681@S2101-09.ap.freescale.net>
Message-ID: <20120131114659.GE2085@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 11:20:24AM +0800, Shawn Guo wrote:
> On Mon, Jan 30, 2012 at 05:46:14PM +0000, Dave Martin wrote:
> > Compiled device tree blobs shouldn't be committed in the kernel
> > tree, so ideally git should ignore them.
> > 
> > This patch will enable ignoring of any .dtb files which appear in
> > arch/arm/boot/
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I added my ack tag on the same patch below, but it died in the end?
> 
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/144097

I don't mind too much which patch goes in -- do we care about whether
other .dtb files can be included in the kernel?


I would suggest that it is just plain wrong for _binary_ devicetree
blobs to appear in the kernel tree, since there is a readily usable
source form for the same thing (this isn't firmware)

Do we think that the '.dtb' filename extension might get used foro
something else?

Cheers
---Dave

> 
> Regards,
> Shawn
> 
> > ---
> >  arch/arm/boot/.gitignore |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/.gitignore b/arch/arm/boot/.gitignore
> > index ce1c5ff..3c79f85 100644
> > --- a/arch/arm/boot/.gitignore
> > +++ b/arch/arm/boot/.gitignore
> > @@ -3,3 +3,4 @@ zImage
> >  xipImage
> >  bootpImage
> >  uImage
> > +*.dtb
> > -- 
> > 1.7.4.1
