From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 21 Dec 2012 12:49:53 +0100
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <CAOMZO5B3EXOB4ijh0LOhvU4g67kdz8KSXw8dvS2dOD1anu_8Bw@mail.gmail.com>
References: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
 <20121218024353.GA17118@kroah.com>
 <CAOMZO5DTB79e3W1_i2NLin7RWXVzraoysEGVLxv9_aoRS39D4Q@mail.gmail.com>
 <20121220043943.GA992@nchen-desktop>
 <CAOMZO5B1DyktHa0Vfb4+-H9bdxaoacas6ZCHEH0bDLuKiCB6hA@mail.gmail.com>
 <CAOMZO5B5hv+oG+8fQYyFxRb=VLOiPmC8+0LhAFLOOzBY4z6PZA@mail.gmail.com>
 <CAOMZO5Dhasq11fyJj73_UcyVdoz-N0MAHBu0=PQUxRn42VOdkw@mail.gmail.com>
 <20121221022249.GA16251@nchen-desktop>
 <CAOMZO5B3EXOB4ijh0LOhvU4g67kdz8KSXw8dvS2dOD1anu_8Bw@mail.gmail.com>
Message-ID: <20121221114953.GA2678@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 07:24:14AM -0200, Fabio Estevam wrote:
> Hi Peter,
> 
> On Fri, Dec 21, 2012 at 12:22 AM, Peter Chen <peter.chen@freescale.com> wrote:
> 
> > Current chipidea driver only considers disable stream mode at device
> > mode, in fact, it may be related to below chipidea bug, and needs
> > to consider all usb modes.
> >
> > STAR 9000378958
> > Title: Non-Double Word Aligned Buffer Address Sometimes Causes Host to Hang on OUT Retry
> > www.synopsys.com/dw/star.php?c=dwc_usb2_hs_otg_controller&fixedIn=2.20a
> >
> > To fix this, we need to add CI13XXX_DISABLE_STREAMING after role->start/init.
> 
> Yes, setting CI13XXX_DISABLE_STREAMING inside ci_role_start does work.
> 
> If you think the patch below is fine I can properly submit it.

Why did you need to move this function?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121221/9bb22a4b/attachment.sig>
