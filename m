From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 22 May 2017 21:30:22 +0200
Subject: [PATCH v4 00/20] eeprom: at24: Add OF device ID table
In-Reply-To: <CABxcv==8R5_tG8-rsp-9UdS_5N7X8QXkd0OFnN63Ct7L2jFvhA@mail.gmail.com>
References: <20170522140208.24652-1-javier@dowhile0.org>
 <CAMuHMdXbhkGGFC80-39Axzv=BdEXyBNuPuHCSWW3eXWDB=SQ+w@mail.gmail.com>
 <CAL_JsqL2P=C+xRyL-BCC=RtFah4BRf8BHSvWNPZ+6r2ioSk_Yw@mail.gmail.com>
 <CABxcv==xw7UxF1Ey+hDhGb_wzgAcFR9JLm6iuirvYSTTvSxb0A@mail.gmail.com>
 <CAL_JsqKj_f-jY3wi78QyAAov=a9-ReaT9qU=ytwSp+5RL0eutg@mail.gmail.com>
 <CABxcv==8R5_tG8-rsp-9UdS_5N7X8QXkd0OFnN63Ct7L2jFvhA@mail.gmail.com>
Message-ID: <CAMuHMdVaY6J04TL=cEBVkCx=qhQuvbprxXt4VCjh_oEedRYnzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Mon, May 22, 2017 at 7:15 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>>> I also wonder why this is really needed if AFAIU "renesas,24c02" is
>>> compatible with "atmel,24c02". IOW, the driver doesn't need to
>>> differentiate between the two since the devices are the same and will
>>> always match using "atmel,24c02".
>>
>> It is needed, so that when a difference is found, it can be handled
>> without updating the DT.
>
> Yes, I understand this. What I tried to ask is if there could really
> be a difference for the same chip type between different vendors, or
> is just that people were using other manufacturers in the compatible
> string as a consequence of the DT binding doc and the I2C core
> ignoring the vendor prefix.

The devices from different vendors are not the same. They contain FLASH
ROM of a specific size, and glue logic to expose an i2c slave
interface providing
an AT24-compatible command set.  They should behave similar within
the limits of the AT24 "spec".  But the actual implementation may be different.

> I don't mind though, I will leave the manufacturers that are different
> than the atmel variants in the mainline DTS as you and Geert asked.

OK, thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
