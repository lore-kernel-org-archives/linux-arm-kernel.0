From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 25 Nov 2010 16:12:24 +0300
Subject: [PATCH v2 3/3] USB: cns3xxx: Add EHCI and OHCI bus glue for
	cns3xxx SOCs
In-Reply-To: <20101124162512.GB10890@oksana.dev.rtsoft.ru>
References: <1290443565-20766-1-git-send-email-mkl0301@gmail.com>
	<1290443565-20766-4-git-send-email-mkl0301@gmail.com>
	<20101124162512.GB10890@oksana.dev.rtsoft.ru>
Message-ID: <20101125131224.GA15916@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 07:25:12PM +0300, Anton Vorontsov wrote:
> On Tue, Nov 23, 2010 at 12:32:45AM +0800, mkl0301 at gmail.com wrote:
> > From: Mac Lin <mkl0301@gmail.com>
> > 
> > The CNS3XXX SOC has include USB EHCI and OHCI compatible controllers. This
> > patch adds the necessary glue logic to allow ehci-hcd and ohci-hcd drivers to
> > work on CNS3XXX
> > 
> > The EHCI and OHCI controllers share a common clock control and reset bit,
> > therefore additional check for the timming of enabling and disabling is
> > required. The USB bit of PLL Power Down Control is also shared by OTG, 24MHz
> > UART clock, Crypto clock, PCIe reference clock, and Clock Scale Generator.
> > Therefore we only ensure it is enabled, while not disabling it.
> > 
> > Signed-off-by: Mac Lin <mkl0301@gmail.com>
> 
> Thanks for the patch!
> 
> A few (mostly cosmetic) comments down below.
[...]
> > +#ifdef CNS3XXX_USB_BASE_VIRT
> > +	hcd->regs = (void __iomem *) CNS3XXX_USB_BASE_VIRT;
> > +#else

Oh, and also. Please get rid of these #ifdefs. There is no
CNS3XXX_USB_BASE_VIRT anymore. So, just remove them.

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
