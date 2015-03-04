From: joe@perches.com (Joe Perches)
Date: Wed, 04 Mar 2015 09:21:15 -0800
Subject: [PATCH 4.0-rc1 v17 4/6] printk: Simple implementation for NMI
 backtracing
In-Reply-To: <1425486786.2769.25.camel@linaro.org>
References: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
 <1425463974-23568-1-git-send-email-daniel.thompson@linaro.org>
 <1425463974-23568-5-git-send-email-daniel.thompson@linaro.org>
 <1425485601.2712.9.camel@perches.com>
 <20150304112010.338501ab@gandalf.local.home>
 <1425486786.2769.25.camel@linaro.org>
Message-ID: <1425489675.2712.16.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-03-04 at 16:33 +0000, Daniel Thompson wrote:
> On Wed, 2015-03-04 at 11:20 -0500, Steven Rostedt wrote:
> > On Wed, 04 Mar 2015 08:13:21 -0800
> > Joe Perches <joe@perches.com> wrote:
> > 
> > > On Wed, 2015-03-04 at 10:12 +0000, Daniel Thompson wrote:
> > > > Currently there is a quite a pile of code sitting in
> > > > arch/x86/kernel/apic/hw_nmi.c to support safe all-cpu backtracing from NMI.
> > > > The code is inaccessible to backtrace implementations for other
> > > > architectures, which is a shame because they would probably like to be
> > > > safe too.
> > > > 
> > > > Copy this code into printk. We'll port the x86 NMI backtrace to it in a
> > > > later patch.
> > > 
> > > I think this would be better as a separate file
> > > rather than increasing the bulk of printk.c
> > > 
> > I agree, as printk already has its own directory. Perhaps a
> > "nmi_backtrace.c"?
> 
> I agree on moving the code. However, after Thomas' review I made sure
> all the external symbols were prefixed printk_nmi and, as a result of
> the same review I started using CONFIG_PRINTK_NMI to enable/disable the
> feature). For that reason I'm much more inclined to name it
> "printk_nmi.c". Any objections?

Steven's suggestion seems more sensible.

sed 's/CONFIG_PRINTK_NMI/CONFIG_PRINTK_NMI_BACKTRACE/g'
sed 's/printk_nmi/printk_nmib/g'
or
sed 's/printk_nmi/nmi_backtrace/g'

might work well.
