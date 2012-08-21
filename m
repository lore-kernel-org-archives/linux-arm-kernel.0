From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 15:00:54 +0300
Subject: [RFC/PATCH 4/4] gpio: smscece: Add support for gpio IO expander
 feature
In-Reply-To: <CAKdam56DiFpnoQwrHe1tjQWLMy5vP9ynstNj_n=OyMxkJJAUOA@mail.gmail.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-5-git-send-email-sourav.poddar@ti.com>
 <20120821105333.GW10347@arwen.pp.htv.fi>
 <CAKdam56DiFpnoQwrHe1tjQWLMy5vP9ynstNj_n=OyMxkJJAUOA@mail.gmail.com>
Message-ID: <20120821120052.GD10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 21, 2012 at 05:17:37PM +0530, Poddar, Sourav wrote:
> >> +     if (type & IRQ_TYPE_LEVEL_HIGH)
> >> +             sg->int_lvl[bank] |= bit;
> >> +     else if (type & IRQ_TYPE_LEVEL_LOW)
> >> +             sg->int_lvl[bank] &= ~bit;
> >> +     else
> >> +             return -EINVAL;
> >
> > this looks wrong. You could have a user who wants to trigger on both
> > HIGH and LOW levels, no ?
> >
> Yes, I think there can be a scenario where gpio_keys are attached
> to this driver and signals a "key press" at low and "key release" at
> high. ?
>  Will figure out a way to add support to check for case where
> both High and low levels are used.

could probably be done on a separate patch, maybe... Just now I saw that
HIGH and LOW levels use the same bit.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/c672efb3/attachment.sig>
