From: marex@denx.de (Marek Vasut)
Date: Mon, 25 Jun 2012 16:20:10 +0200
Subject: [PATCH v7 04/14] usb: chipidea: msm: add remove method
In-Reply-To: <20120625141443.GB601@arwen.pp.htv.fi>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <201206251555.22820.marex@denx.de> <20120625141443.GB601@arwen.pp.htv.fi>
Message-ID: <201206251620.10442.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Felipe Balbi,

> Hi,
> 
> On Mon, Jun 25, 2012 at 03:55:22PM +0200, Marek Vasut wrote:
> > Dear ABRAHAM, KISHON VIJAY,
> > 
> > > Hi,
> > > 
> > > On Mon, Jun 25, 2012 at 7:03 PM, Marek Vasut <marex@denx.de> wrote:
> > > > Dear ABRAHAM, KISHON VIJAY,
> > > > 
> > > >> Hi,
> > > >> 
> > > >> On Mon, Jun 25, 2012 at 12:26 PM, Richard Zhao
> > > >> 
> > > >> <richard.zhao@freescale.com> wrote:
> > > >> > From: Felipe Balbi <balbi@ti.com>
> > > >> > 
> > > >> > allow this driver to be removed too.
> > > >> > 
> > > >> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > >> > Signed-off-by: Alexander Shishkin
> > > >> > <alexander.shishkin@linux.intel.com> ---
> > > >> > 
> > > >> >  drivers/usb/chipidea/ci13xxx_msm.c |   20 ++++++++++++++------
> > > >> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > > >> > 
> > > >> > diff --git a/drivers/usb/chipidea/ci13xxx_msm.c
> > > >> > b/drivers/usb/chipidea/ci13xxx_msm.c index 8d438b8..68512d4 100644
> > > >> > --- a/drivers/usb/chipidea/ci13xxx_msm.c
> > > >> > +++ b/drivers/usb/chipidea/ci13xxx_msm.c
> > > >> > @@ -84,6 +84,8 @@ static int __devinit ci13xxx_msm_probe(struct
> > > >> > platform_device *pdev) if (ret)
> > > >> > 
> > > >> >                goto put_platform;
> > > >> > 
> > > >> > +       platform_set_drvdata(pdev, plat_ci);
> > > >> > +
> > > >> > 
> > > >> >        pm_runtime_no_callbacks(&pdev->dev);
> > > >> >        pm_runtime_enable(&pdev->dev);
> > > >> > 
> > > >> > @@ -95,16 +97,22 @@ put_platform:
> > > >> >        return ret;
> > > >> >  
> > > >> >  }
> > > >> > 
> > > >> > +static int __devexit ci13xxx_msm_remove(struct platform_device
> > > >> > *pdev) +{
> > > >> > +       struct platform_device *plat_ci =
> > > >> > platform_get_drvdata(pdev);
> > > >> 
> > > >> How about a pm_runtime_disable() here?
> > > > 
> > > > MX28 doesn't do runtime PM yet. Actually it doesn't do any PM.
> > > 
> > > I was probably misled by the call to pm_runtime_enable in your probe
> > > 
> > > :-( Then can we have it removed from probe as well?
> > 
> > Yes, either that or properly add runtime PM support since mxc maybe does
> > support it, I dunno right now.
> 
> I think adding pm_runtime_disable() to the exit path should be the way
> to go. proper callbacks can be implemented later, but we cannot leave pm
> enabled for the device.

Agreed

Best regards,
Marek Vasut
