From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 23 Jul 2013 02:44:59 +0200
Subject: [PATCH v2 6/8] usb: host: ohci-s3c2410 Use
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <CAOMZO5D4X+GT+LdUOjorJ8xgBCwv9iAP4W-RzKrbnE-93kxmUg@mail.gmail.com>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
 <1374536965-3545-7-git-send-email-tomasz.figa@gmail.com>
 <CAOMZO5D4X+GT+LdUOjorJ8xgBCwv9iAP4W-RzKrbnE-93kxmUg@mail.gmail.com>
Message-ID: <1749259.aa65CrEVoR@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 of July 2013 21:15:12 Fabio Estevam wrote:
> On Mon, Jul 22, 2013 at 8:49 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> >         dev_dbg(&dev->dev, "s3c2410_start_hc:\n");
> > 
> > -       clk_enable(usb_clk);
> > +       clk_prepare_enable(usb_clk);
> 
>  clk_prepare_enable may fail, so you would better check its return
> value.

Well, ideally yes, but since this driver doesn't have any error path here 
anyway and on Samsung platforms clk_prepare_enable() simply can't fail, 
I'd keep it this way until somebody fixes this driver, as it has more 
issues than just this one.

Best regards,
Tomasz
