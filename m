From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Wed, 29 Jul 2015 21:54:58 +0000
Subject: [PATCH v3 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
In-Reply-To: <CAOMZO5DaZ+1Ud0RAX2RELz5c0zyZUo_X1y50gY2XwM5o0BeVmg@mail.gmail.com>
References: <1438203535-38028-1-git-send-email-shenwei.wang@freescale.com>
 <CAOMZO5Aj5PASPKRq47vmenDBSPMPHdLgSbJZXkhZu3MNYprqXA@mail.gmail.com>
 <CY1PR0301MB0843BEF6A40A0A28018E0D5D838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <CAOMZO5DaZ+1Ud0RAX2RELz5c0zyZUo_X1y50gY2XwM5o0BeVmg@mail.gmail.com>
Message-ID: <CY1PR0301MB08437D6E977C99821622976A838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: 2015?7?29? 16:46
> To: Wang Shenwei-B38339
> Cc: Greg Kroah-Hartman; linux-arm-kernel at lists.infradead.org;
> linux-serial at vger.kernel.org
> Subject: Re: [PATCH v3 1/1] Serial: imx: add dev_pm_ops to support suspend to
> ram/disk
> 
> On Wed, Jul 29, 2015 at 6:41 PM, Shenwei Wang <Shenwei.Wang@freescale.com>
> wrote:
> 
> >> clk_enable() may fail, so you should check its return value.
> >
> > The check seems a little superfluous because the failure condition for
> > clk_enable is (clk == NULL || IS_ERR(clk)) Once this function is
> > called which means the initialization of the driver is successful.
> 
> Not superfluos. You can't assume that clk_enable() will always be successful.
> Better check its return value.

I am very interesting to know if you could provide an example condition that may cause 
clk_enable failed in this callback function?

Regards,
Shenwei
