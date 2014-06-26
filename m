From: marex@denx.de (Marek Vasut)
Date: Thu, 26 Jun 2014 11:50:01 +0200
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
In-Reply-To: <201406261126.09235.jbe@pengutronix.de>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
 <201406261117.12542.marex@denx.de> <201406261126.09235.jbe@pengutronix.de>
Message-ID: <201406261150.01965.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 26, 2014 at 11:26:09 AM, Juergen Borleis wrote:
> Hi Marek,
> 
> On Thursday 26 June 2014 11:17:12 Marek Vasut wrote:
> > On Thursday, June 26, 2014 at 09:32:30 AM, Juergen Borleis wrote:
> > > On Thursday 26 June 2014 05:43:19 Fabio Estevam wrote:
> > > > [...]
> > > 
> > > > Below is the log with linux-next kernel and earlyprintk enabled:
> > > Does it also hang when you disable "earlyprintk"? A few weeks ago we
> > > had a similar issue with i.MX6/PCI and "earlyprintk" (at the end it
> > > was caused by a clock change for the UART when changing from the early
> > > to the regular console).
> > 
> > How can the UART clock have impact on the PCIe please ?
> 
> Not to the PCIe hardware, it just hanged the kernel when the PCIe driver
> came up (due to some of its messages it tries to output at this moment).

Another hint, can a blocking msleep() hang the driver ? The driver probes in 
fs_initcall stage, I'm not sure if it cannot hit some kind of a problem when 
using the msleep() ? It's unlikely though ...

Best regards,
Marek Vasut
