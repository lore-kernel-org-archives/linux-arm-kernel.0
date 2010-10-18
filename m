From: guenter.roeck@ericsson.com (Guenter Roeck)
Date: Mon, 18 Oct 2010 11:35:30 -0700
Subject: [PATCH 1/2] hwmon: add generic GPIO fan driver
In-Reply-To: <4CBC8B3B.8090201@free.fr>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com> <4CBC8B3B.8090201@free.fr>
Message-ID: <20101018183530.GA10070@ericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 18, 2010 at 02:00:27PM -0400, Chris Moore wrote:
> 
>   Hi,
> 
> Le 18/10/2010 18:08, Guenter Roeck a ?crit :
> > On Sun, Oct 17, 2010 at 11:50:11AM -0400, Simon Guinot wrote:
> >
> >> +static void __set_fan_ctrl(struct gpio_fan_data *fan_data, int ctrl_val)
> >> +{
> >> +       int i;
> >> +
> >> +       for (i = 0; i<  fan_data->num_ctrl; i++) {
> >> +               int value = !!(ctrl_val&  (1<<  i));
> >> +
> > 	value = (ctrl_val&  (1>>  i));
> >      would be much simpler and easier to understand.
> 
> IMHO you mean:
> 
> 	value = (ctrl_val>>  i)&  1;
> 
yes...

thanks for the correction.

Guenter
