From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 28 Nov 2013 10:45:40 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAyLzJdIHVzYjogY2hpcGlkZWE6IHVzYm1pc2M6IEFk?=
 =?UTF-8?B?ZCBzdXBwb3J0IGZvciBpLk1YNTEgQ1BV?=
In-Reply-To: <20131128022807.GC5850@S2101-09.ap.freescale.net>
References: <1385480210-9349-1-git-send-email-shc_work@mail.ru>
 <1385480210-9349-2-git-send-email-shc_work@mail.ru>
 <20131128022807.GC5850@S2101-09.ap.freescale.net>
Message-ID: <1385621140.705453514@f214.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> On Tue, Nov 26, 2013 at 07:36:50PM +0400, Alexander Shiyan wrote:
> > This adds i.MX51 as the next user of the usbmisc driver.
> > Functionality is similar to i.MX53, so at this stage simply
> > reuse existing i.MX53 calls.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  drivers/usb/chipidea/usbmisc_imx.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> > index 4381c5a6..cd061ab 100644
> > --- a/drivers/usb/chipidea/usbmisc_imx.c
> > +++ b/drivers/usb/chipidea/usbmisc_imx.c
> > @@ -204,6 +204,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
> >  		.data = &imx27_usbmisc_ops,
> >  	},
> >  	{
> > +		.compatible = "fsl,imx51-usbmisc",
> > +		.data = &imx53_usbmisc_ops,
> 
> If it simply uses imx53 ops, why do we need to introduce a new
> compatible?

This has been discussed here:
http://www.spinics.net/lists/linux-usb/msg97502.html

Additionally, "fsl,imx51-usbmisc" string already present in imx51.dtsi.
Thanks.

---
