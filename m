From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 May 2012 10:59:22 +0200
Subject: Booting mx31 on linux-next-20120517
In-Reply-To: <CAOMZO5BUBAcx9ESLau9b4osE3jQNnh1CXW7FgkmbQ1aS57bOCg@mail.gmail.com>
References: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
 <CAOMZO5BUBAcx9ESLau9b4osE3jQNnh1CXW7FgkmbQ1aS57bOCg@mail.gmail.com>
Message-ID: <20120518085922.GQ30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 01:07:07AM -0300, Fabio Estevam wrote:
> On Fri, May 18, 2012 at 12:48 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > Hi Sascha,
> >
> > Are you able to boot any mx31 system on linux-next-20120517?
> >
> > Just wanted to check with you first before start debugging this issue.
> 
> Adding earlyprintk shows me the following:

Looks familiar. Check the pinctrl support. The i.MX UART driver (and
also the FEC driver) do a devm_pinctrl_get_select_default which does
not seem to be complete. Either the pinctrl dummy providers did not make
it to -next yet or they are simply not activated.


Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
