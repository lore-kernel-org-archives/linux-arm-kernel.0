From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 27 Apr 2012 19:24:57 +0800
Subject: [PATCH v3 2/4] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <20120427085402.GV2234@S2101-09.ap.freescale.net>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <1335451227-27709-2-git-send-email-b29396@freescale.com>
 <20120427085402.GV2234@S2101-09.ap.freescale.net>
Message-ID: <20120427112457.GG826@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 04:54:05PM +0800, Shawn Guo wrote:
> On Thu, Apr 26, 2012 at 10:40:25PM +0800, Dong Aisheng wrote:
> > +/**
> > + * struct imx_pin_reg - describe a pin reg map
> > + * The last 3 members are used for select input setting
> > + * @pid: pin id
> > + * @mux_reg: mux register offset
> > + * @conf_reg: config register offset
> > + * @mux_mode: mux mode
> > + * @input_reg: select input register offset for this mux if any
> > + *  0 if no select input setting needed.
> > + * @input_val: the value set to select input register
> > + */
> > +struct imx_pin_reg {
> > +	unsigned int pid;
> > +	unsigned int mux_reg;
> > +	unsigned int conf_reg;
> > +	unsigned int mux_mode;
> > +	unsigned int input_reg;
> > +	unsigned int input_val;
> > +};
> 
> Since the array of this struct is big, I would suggest define the type
> of the members as size-efficient as possible, for example, u16 is enough
> for pid, and reg offset, while u8 is enough for mux_mode?
> 
Yes, reasonable.
Will change to that in v4.

Regards
Dong Aisheng
