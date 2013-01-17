From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 17 Jan 2013 12:25:41 +0100
Subject: [PATCH v6 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
In-Reply-To: <CAOMZO5Chu0bcXPqn+wWHwAqLu+27DvLx1=Bzaffpd-bA2ahaAQ@mail.gmail.com>
References: <1358416874-27011-1-git-send-email-peter.chen@freescale.com>
 <1358416874-27011-2-git-send-email-peter.chen@freescale.com>
 <CAOMZO5Chu0bcXPqn+wWHwAqLu+27DvLx1=Bzaffpd-bA2ahaAQ@mail.gmail.com>
Message-ID: <20727.57269.347099.324284@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Fabio Estevam writes:
> On Thu, Jan 17, 2013 at 8:01 AM, Peter Chen <peter.chen@freescale.com> wrote:
> 
> >         /* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
> > -       if (!cpu_is_mx51()) {
> > +       if (!strcmp(pdev->id_entry->name, "imx-udc-mx27")) {]]
> 
> Shouldn't this be:
>  if (!strcmp(pdev->id_entry->name, "imx-udc-mx51"))
>
The equivalent of !cpu_is_mx51() would be
strcmp(pdev->id_entry->name, "imx-udc-mx51") (without the '!') meaning
id_entry->name is different from "imx-udc-mx51".

I personally hate the '!strcmp()' notation and prefer 'strcmp() == 0'
though they are technically equivalent. Using '==' makes it much
clearer to the reader what is intended.
!strcmp() lets one assume that it is true when the comparison fails,
though actually the opposite is true.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
