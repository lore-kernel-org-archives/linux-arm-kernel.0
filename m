From: amit.walambe@eurotech.com (Amit Walambe)
Date: Thu, 11 Feb 2010 12:33:44 +0530
Subject: [PATCH] Eurotech Zeus : Making USB port 2 work
In-Reply-To: <37cba69b59077aff2450e9b89c9d0d20.squirrel@www.loen.fr>
References: <20100210120555.1b648467@ironhide>
	<37cba69b59077aff2450e9b89c9d0d20.squirrel@www.loen.fr>
Message-ID: <20100211123344.28014152@ironhide>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
Thanks for your comments Marc.

On Wed, 10 Feb 2010 09:38:38 -0000 (GMT)
"Marc Zyngier" <maz@misterjones.org> wrote:
> >  static struct pxaohci_platform_data zeus_ohci_platform_data = {
> >  	.port_mode	= PMM_NPS_MODE,
> > -	.flags		= ENABLE_PORT_ALL |
> > POWER_CONTROL_LOW | POWER_SENSE_LOW,
> > +	/* Clear Power Control Polarity Low and set Power Sense
> > +	 * Polarity Low. Supply power to USB ports. */
> > +	.flags		= ENABLE_PORT_ALL |
> > ~(POWER_CONTROL_LOW) | POWER_SENSE_LOW,
> 
> I suppose that is actually what makes it work, though the change is
> rather suspect. You're basically setting *all* bits to 1
My bad. Attaching a modified patch. I have tested it on a Zeus and it
works ok.

> > -MACHINE_START(ARCOM_ZEUS, "Arcom ZEUS")
> > +MACHINE_START(ARCOM_ZEUS, "Arcom/Eurotech ZEUS")
> 
> Please sent this as a separate patch, including a Signed-off-by: line.
Please see attached.

> Thanks,
> 
>         M.

Thanks and regards,
- Amit

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
-------------- next part --------------
A non-text attachment was scrubbed...
Name: arcom-to-eurotech.patch
Type: text/x-patch
Size: 667 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100211/e0396c8d/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: eurotech_zeus_usb_port2.patch
Type: text/x-patch
Size: 829 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100211/e0396c8d/attachment-0001.bin>
