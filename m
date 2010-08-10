From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Aug 2010 09:15:38 +0200
Subject: [PATCH 4/8] ARM i.MX: add SDMA driver
In-Reply-To: <4C605150.7030403@gmail.com>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-5-git-send-email-s.hauer@pengutronix.de>
	<4C605150.7030403@gmail.com>
Message-ID: <20100810071538.GE27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 09, 2010 at 09:04:48PM +0200, Magnus Lilja wrote:
> Hi Sascha,
> 
> Just some typos that I spotted.
> 
> > +struct sdma_state_registers {
> > +	u32 sf     : 1; /* source falut while loading data */
>                                   ^^^^^ typo?
> 
> > +	u32 unused0: 1;
> > +	u32 rpc    :14; /* return program counter */
> > +	u32 t      : 1; /* test bit:status of arithmetic & test instruction*/
> > +	u32 unused1: 1;
> > +	u32 pc     :14; /* program counter */
> > +	u32 lm     : 2; /* loop mode */
> > +	u32 epc    :14; /* loop end program counter */
> > +	u32 df     : 1; /* destiantion falut while storing data */
>                            ^^^^^^^^^^^^^^^^^ typos
> 
> > +	u32 unused2: 1;
> > +	u32 spc    :14; /* loop start program counter */
> > +};
> > +#else
> > +struct sdma_state_registers {
> > +	u32 pc     :14; /* program counter */
> > +	u32 unused1: 1;
> > +	u32 t      : 1; /* test bit: status of arithmetic & test instruction*/
> > +	u32 rpc    :14; /* return program counter */
> > +	u32 unused0: 1;
> > +	u32 sf     : 1; /* source falut while loading data */
>                                     ^^^ typo?

I'm glad I copied these typos from the fsl kernel and haven't invented
them myself. What the heck is a falut? fault?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
