From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 3 Feb 2011 12:32:38 +0100
Subject: [PATCHv2 1/2] ads7846: OMAP3: Removal of warnings backtrace in
	bootup
In-Reply-To: <4D4A8DA0.1010806@compulab.co.il>
References: <1296726514-32146-1-git-send-email-sourav.poddar@ti.com>
	<4D4A7F13.8080502@compulab.co.il> <4D4A80D3.2060407@compulab.co.il>
	<AANLkTi=U1qo=udB=tMyuA2HcnCS4EmreaVDbw2vQ9dY8@mail.gmail.com>
	<4D4A8DA0.1010806@compulab.co.il>
Message-ID: <19786.37462.662253.3644@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Igor Grinberg writes:
> 
> 
> On 02/03/11 13:00, Poddar, Sourav wrote:
> 
> > On Thu, Feb 3, 2011 at 3:47 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> >> if (pdata->get_pendown_state) {
> >>        ts->get_pendown_state = pdata->get_pendown_state;
> >>        ts->gpio_pendown = -1;
> >>        return 0;
> >> }
> > Yes we can do so .I initialise it at a place where other variables
> >  where initialised.
> >
> >>> Also, why don't we use -EINVAL for the invalid gpio number instead of -1 constant?
> >>>
> >  I used -1 because conditional check done in probe ads7846_probe function
> >  used this value.
> >
> >   err_free_gpio:
> >         if (ts->gpio_pendown != -1)
> >                 gpio_free(ts->gpio_pendown);
> >
> 
> Well I understand that and that's why in my proposal I used -1 also, but
> I thought we can make it even better if we switch to -EINVAL
> (though wanted to check if there are any reasonable objections)
> and while you are at this, may be you are willing also to submit a patch for this?
> 
Since ts->gpio_pendown is used as a GPIO number, the check with
gpio_is_valid(), as suggested by Felipe Balbi, would be the most
sensible thing to do here.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
