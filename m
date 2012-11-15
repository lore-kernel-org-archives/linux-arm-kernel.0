From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 15 Nov 2012 14:54:42 +0100
Subject: [PATCH 6/6] usb: chipidea: usbmisc: add post handling and errata
 fix for mx25
In-Reply-To: <CALBypN7-NKFmoPXWA0utFhUjLOWjvzwJ7ZSuQBa+W5edNQA_OA@mail.gmail.com>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352894137-2050-7-git-send-email-m.grzeschik@pengutronix.de>
 <CALBypN6U=np93ZwnEZqbh=j0Vb_-x630GaktEiv+4K26eYp4Pg@mail.gmail.com>
 <20121115102525.GA16118@pengutronix.de>
 <CALBypN7-NKFmoPXWA0utFhUjLOWjvzwJ7ZSuQBa+W5edNQA_OA@mail.gmail.com>
Message-ID: <50A4F422.4010606@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2012 02:51 PM, Martin Fuzzey wrote:
>> This is because that series is based on Peter Chen's work. I should have
>> mentioned this in the cover-letter mail. You can merge his master branch
>> before adding my series:
> 
> Ok thanks for the very rapid reply.
> 
> I've now built this together with patch 2 "ci13xxx_imx: add 2nd and
> 3rd clock to support imx5x and newer" from your other series.
> But it hangs because the usb-phy clock is not being enabled.
> If I add a clock enable for that clock too to usbmisc_imx.c it works
> but that can't be the right way.
> 
> Who is supposed to enable the phy clock?
> [I'm using the OTG port in host only mode on i.MX53 with "nop-usbphy"]
> 
> Here's what I did (illustration only, probably white space broken):

We've have a patch that the missing clock handling to the nop phy
driver, which isn't much better. What are other possible options?

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121115/0a32aec2/attachment.sig>
