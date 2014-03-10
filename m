From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Mon, 10 Mar 2014 06:55:20 +0100
Subject: [PATCH 1/9] usb: chipidea: usbmisc: Add USB Host support for
 i.MX25/i.MX35 CPUs
In-Reply-To: <CAOMZO5DPK41DqNT7b_eV2owqPvAsqHZ7zgkqDVSmPUx2Bv2TVA@mail.gmail.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <CAOMZO5DPK41DqNT7b_eV2owqPvAsqHZ7zgkqDVSmPUx2Bv2TVA@mail.gmail.com>
Message-ID: <20140310065520.469cac2e@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Le Sun, 9 Mar 2014 22:21:59 -0300,
Fabio Estevam <festevam@gmail.com> a ?crit :
> On Fri, Mar 7, 2014 at 2:04 PM, Denis Carikli <denis@eukrea.com> wrote:
> 
> > +static int usbmisc_imx25_init(struct imx_usbmisc_data *data)
> > +{
> > +       void __iomem *reg = NULL;
> 
> This variable is not used and causes a warning. Please remove it.
> 
> After applying this patch things go further when I boot with a USB
> thumb connected to the USB Host1 port:
> 
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> usbcore: registered new interface driver usb-storage
> 53ff4400.usb supply vbus not found, using dummy regulator
> ci_hdrc ci_hdrc.0: EHCI Host Controller
> ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
> ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> ....
> 
> usb 1-1: new full-speed USB device number 2 using ci_hdrc
> 
> (Not sure why it says full-speed device. When I connect the same
> device to a PC it says high-speed)
> 
because i.MX25 and i.MX35 only have a full speed phy on the host port.

Eric
