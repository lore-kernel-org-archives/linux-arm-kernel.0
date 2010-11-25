From: gregkh@suse.de (Greg KH)
Date: Thu, 25 Nov 2010 09:15:41 -0800
Subject: [PATCH v3 1/1] USB: cns3xxx: Add EHCI and OHCI bus glue for
	cns3xxx SOCs
In-Reply-To: <20101125162158.GB2580@oksana.dev.rtsoft.ru>
References: <1290700680-20066-1-git-send-email-mkl0301@gmail.com>
	<20101125162158.GB2580@oksana.dev.rtsoft.ru>
Message-ID: <20101125171541.GA18152@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 07:21:58PM +0300, Anton Vorontsov wrote:
> On Thu, Nov 25, 2010 at 11:58:00PM +0800, mkl0301 at gmail.com wrote:
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
> Cc'ing Greg.
> 
> Greg, the patch doesn't touch any sensitive parts of EHCI and OHCI
> drivers, can I take it via ARM subtree? This is to not introduce
> cross-tree dependencies (the patch depends on some arch-specific
> changes).

Please get Alan Stern to ack it as well, as he knows the proper
callbacks that you need to ensure are present.

thanks,

greg k-h
