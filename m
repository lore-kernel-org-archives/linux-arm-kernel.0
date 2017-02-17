From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Fri, 17 Feb 2017 15:35:11 +0800
Subject: [PATCH 4/5] sprd_serial: switch comptible string to sc-uart
In-Reply-To: <1761969.45NG6Q1Iyc@wuerfel>
References: <1487063952-7113-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1487063952-7113-5-git-send-email-chunyan.zhang@spreadtrum.com>
 <1761969.45NG6Q1Iyc@wuerfel>
Message-ID: <20170217073511.GB8767@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?,  2? 16, 2017 at 02:31:38?? +0100, Arnd Bergmann wrote:
> On Tuesday, February 14, 2017 5:19:11 PM CET Chunyan Zhang wrote:
> >  static const struct of_device_id serial_ids[] = {
> > -       {.compatible = "sprd,sc9836-uart",},
> > +       {.compatible = "sprd,sc-uart",},
> >         {}
> 
> We really need this to be specific, in case Spreadtrum ever
> makes a slightly different UART that is not 100% compatible
> with this one. Also, you can't remove the string you already have,
> only add to it.
>
> Normally when you have a new chip that is compatible with one
> we already have a driver for, we mark the device as compatible
> with the old one and avoid having to change the driver, e.g.
> 
> 	compatible = "sprd,sc9995-uart", "sprd,sc9836-uart";
> 
> This way, the driver could later be changed to handle anything
> that is compatible with sc9995 differently from sc9836, but
> by default it would match the original string.
> 

Right, I've addressed this when I received the same comments from
Rob Herring :)

Thanks for your comments,
Chunyan
 
> 	Arnd
