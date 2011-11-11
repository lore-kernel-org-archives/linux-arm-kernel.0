From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Nov 2011 15:33:24 +0000
Subject: [PATCH 1/2] ARM: mx28evk: remove flexcan_pdata __initconst
 attribute
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722CED16@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1321024360-5249-1-git-send-email-b29396@freescale.com>
 <20111111150609.GD5011@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F7722CECED@039-SN1MPN1-002.039d.mgd.msft.net>
 <20111111152735.GE12913@n2100.arm.linux.org.uk>
 <65EE16ACC360FA4D99C96DC085B3F7722CED16@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20111111153324.GF12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 03:30:04PM +0000, Dong Aisheng-B29396 wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > Sent: Friday, November 11, 2011 11:28 PM
> > To: Dong Aisheng-B29396
> > Cc: Uwe Kleine-K?nig; Guo Shawn-R65073; s.hauer at pengutronix.de;
> > kernel at pengutronix.de; linux-arm-kernel at lists.infradead.org;
> > w.sang at pengutronix.de
> > Subject: Re: [PATCH 1/2] ARM: mx28evk: remove flexcan_pdata __initconst
> > attribute
> > 
> > On Fri, Nov 11, 2011 at 03:25:01PM +0000, Dong Aisheng-B29396 wrote:
> > > -static struct fec_platform_data tx28_fec0_data = {
> > > +static struct fec_platform_data __initconst tx28_fec0_data = {
> > 
> > No.  It's spelt:
> > 
> > static const struct fec_platform_data tx28_fec0_data __initconst = {
> Thanks for reminder, I missed the first const. :-)

That's not the only thing.  Note the placement of the __initconst too.
