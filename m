From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 15:59:12 +0000
Subject: [PATCH v3 2/2] ARM: SMP: Refactor Kconfig to be more maintainable
In-Reply-To: <20111212150405.GB2296@linaro.org>
References: <1323690426-6267-1-git-send-email-dave.martin@linaro.org>
 <1323690426-6267-3-git-send-email-dave.martin@linaro.org>
 <20111212141001.GZ14542@n2100.arm.linux.org.uk>
 <20111212150405.GB2296@linaro.org>
Message-ID: <20111212155912.GB20178@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 03:04:05PM +0000, Dave Martin wrote:
> On Mon, Dec 12, 2011 at 02:10:01PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 12, 2011 at 11:47:06AM +0000, Dave Martin wrote:
> > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > index 4234937..4aa7f7e 100644
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -611,6 +611,7 @@ config SOC_IMX6Q
> > >  	select ARM_GIC
> > >  	select CPU_V7
> > >  	select HAVE_ARM_SCU
> > > +	select HAVE_SMP
> > >  	select HAVE_IMX_GPC
> > >  	select HAVE_IMX_MMDC
> > >  	select HAVE_IMX_SRC
> > 
> > NAK.  I'll let you work out why.  It has something to do with ABCDEFGH...
> 
> Duh.  Sorry about that -- will fix and repost.
> 
> 
> Do you have a preference about where to insert new items where the list
> is not already in alphabetical order?

What I've done in the past is roughly to ignore anything which isn't
alphabetical from the top, and place it within that subset.  I
simetimes change that (if there's a group of HAVE_xxx which is already
sorted, I add it within that sub-group.)

In other words, try to sensibly place it so the addition itself is
alphabetically between two other options which are already so sorted.
