From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 13 Aug 2015 15:07:20 +0200
Subject: [PATCH v2] gpio: Allow hogged gpios to be requested
In-Reply-To: <CACRpkdZAjWf3Echvz6Z2hTOF8Bqs=OqLKUTYc04r9vzFo727jg@mail.gmail.com>
References: <1438680424-698-1-git-send-email-mpa@pengutronix.de>
 <CACRpkdZAjWf3Echvz6Z2hTOF8Bqs=OqLKUTYc04r9vzFo727jg@mail.gmail.com>
Message-ID: <20150813130720.GV19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 10, 2015 at 11:26:49AM +0200, Linus Walleij wrote:
> On Tue, Aug 4, 2015 at 11:27 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > It can be useful to claim hogged gpios later, for example from
> > userspace. This allows to set defaults for GPIOs using the hogging
> > mechanism and override the setup later from userspace or a kernel driver.
> >
> > This patch adds a check for hogged gpios to allow requesting them. If
> > the gpio is not hogged but marked as requested, it still fails with
> > -EBUSY.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> To me it feels like a new DT property "gpio-inital-value" or so
> need to be defined in addition to the hogging bindings, and that
> one just sets the GPIO up without setting the FLAG_IS_HOGGED.
> 
> The mechanism needs to be available to non-DT as well
> of course, but it could be a first usecase.
> 
> So instead of:
> 
> line_b {
>            gpio-initval;
>            gpios = <6 0>;
>            output-low;
> };
> 
> Note: no line-name. And it shouldn't be allowed: we don't
> know who will use this in the end.

Sounds good to me. If everyone is okay with this I could go ahead and
implement something like this.

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/73758fb7/attachment.sig>
