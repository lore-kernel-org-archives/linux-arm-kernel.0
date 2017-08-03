From: oleksandrs@mellanox.com (Oleksandr Shamray)
Date: Thu, 3 Aug 2017 15:26:08 +0000
Subject: [patch v1 0/2] JTAG driver introduction
In-Reply-To: <20170802141209.GB25781@lunn.ch>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <20170802141209.GB25781@lunn.ch>
Message-ID: <AM4PR0501MB2194E6B8D14EC15356C1C0BFB1B10@AM4PR0501MB2194.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: Wednesday, August 2, 2017 5:12 PM
> To: Oleksandr Shamray <oleksandrs@mellanox.com>
> Cc: gregkh at linuxfoundation.org; arnd at arndb.de; devicetree at vger.kernel.org;
> jiri at resnulli.us; system-sw-low-level <system-sw-low-level@mellanox.com>;
> openbmc at lists.ozlabs.org; linux-kernel at vger.kernel.org; mec at shout.net;
> joel at jms.id.au; linux-serial at vger.kernel.org; vadimp at maellanox.com;
> tklauser at distanz.ch; linux-arm-kernel at lists.infradead.org
> Subject: Re: [patch v1 0/2] JTAG driver introduction
> 
> On Wed, Aug 02, 2017 at 04:18:36PM +0300, Oleksandr Shamray wrote:
> > When a need raise up to use JTAG interface for system's devices
> > programming or CPU debugging, it could be done from the external JTAG
> > master controller.
> >
> > For such purpose, usually the user layer application implements jtag
> > protocol or using a proprietary connection to vendor hardware.
> > This method is slow and not generic.
> >
> > We propose to implement general JTAG interface and infrastructure to
> > communicate with user layer application. In such way, we can have the
> > standard JTAG interface core part and separation from specific HW
> > implementation.
> > This allow new capability to debug the CPU or program system's device
> > via BMC without additional devices nor cost.
> 
> Hi Oleksandr
> 
> Do you have patches for OpenOCD? Or maybe i should ask it another way, what
> user space tools are you using?
> 
> Thanks
> 	Andrew

Hi Andrew

Thanks a lot for review.

We used user space tool for that, which is an adaptation of some Lattice tools, which allows programming of SVF files. We are using it for Lattice CPLD burning, since we have for such devices on our system, but this tool could be used for programming other devices from other vendors as well.

https://github.com/mellanoxbmc/mellanox-bmc-tools

Thanks
Oleksandr
