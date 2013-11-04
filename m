From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 4 Nov 2013 09:21:04 +0100
Subject: [PATCH RFC] clk: add gpio controlled clock
In-Reply-To: <0EB243F40EB34A418EAED8001C4B3AD019EA5EF2@DNCE05.ent.ti.com>
References: <cover.1383312867.git.jsarha@ti.com>
 <c52a7910c6ce33ceed0f38b89953527eee06b0b5.1383312867.git.jsarha@ti.com>
 <20131104084227.3323f98e@ipc1.ka-ro>
 <0EB243F40EB34A418EAED8001C4B3AD019EA5EF2@DNCE05.ent.ti.com>
Message-ID: <20131104092104.4b60d715@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sarha, Jyri wrote:
> >
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> -----Original Message-----
> >From: Lothar Wa?mann [mailto:LW at KARO-electronics.de]
> >Sent: Monday, November 04, 2013 9:42 AM
> >
> >Hi,
> >
> >Jyri Sarha wrote:
> >> The added clk-gpio is a basic clock that can be enabled and disabled
> ...
> >> +    err = gpio_request_one(gpio, gpio_flags, name);
> >> +    if (err) {
> >> +            pr_err("%s: Error requesting clock control gpio %u\n",
> >> +                   __func__, gpio);
> >> +            return ERR_PTR(-EINVAL);
> >>
> >You already have an error code from the gpio_request_one() call.
> >Why return a different one?
> 
> I was just thinking the gpio number is more useful for debugging that the error code. Could print the both of cource.
> 
I wasn't talking about the error message, but the return value of the
function!


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
