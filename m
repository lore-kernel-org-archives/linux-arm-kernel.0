From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 10 Mar 2014 08:58:02 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzldIHVzYjogY2hpcGlkZWE6IHVzYm1pc2M6IEFkZCBV?=
 =?UTF-8?B?U0IgSG9zdCBzdXBwb3J0IGZvciBpLk1YMjUvaS5NWDM1IENQVXM=?=
In-Reply-To: <CAOMZO5DPK41DqNT7b_eV2owqPvAsqHZ7zgkqDVSmPUx2Bv2TVA@mail.gmail.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
 <CAOMZO5DPK41DqNT7b_eV2owqPvAsqHZ7zgkqDVSmPUx2Bv2TVA@mail.gmail.com>
Message-ID: <1394427482.225153574@f354.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????????,  9 ????? 2014, 22:21 -03:00 ?? Fabio Estevam <festevam@gmail.com>:
> Hi Denis,
> 
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
...
> (Not sure why it says full-speed device. When I connect the same
> device to a PC it says high-speed)
...
> (Then system hangs here).
> 
> If I boot without the USB thumb connected, then I reach the prompt,
> however after inserting the USB pen drive into USBH1 there is no
> detection.
> 
> Any ideas?

Fabio, start with to make work USB port on your board in the bootloader.
Then with the previous driver (ehci-mxc).
Most likely problem is a wrong (or missing) clock.
As I mentioned earlier, DTS has incorrect clock nodes.

---
