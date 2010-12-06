From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 06 Dec 2010 14:12:10 +0100
Subject: [PATCH] support PMIC mc13892
In-Reply-To: <87k4jnnmii.fsf@lechat.rtp-net.org>
References: <1291616735-29645-1-git-send-email-yong.shen@freescale.com>
	<87tyirnpbm.fsf@lechat.rtp-net.org>
	<1291635752.3151.43.camel@realization>
	<87k4jnnmii.fsf@lechat.rtp-net.org>
Message-ID: <1291641130.3151.46.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On lun, 2010-12-06 at 12:55 +0100, Arnaud Patard wrote:
> Alberto Panizzo <maramaopercheseimorto@gmail.com> writes:
> 
> > On lun, 2010-12-06 at 11:55 +0100, Arnaud Patard wrote:
> >> <yong.shen@freescale.com> writes:
> >> 
> >> Hi,
> >> 
> >> > From: Yong Shen <yong.shen@linaro.org>
> >> >
> >> > add support for mc13892, tested on mx51 babbage board
> >> 
> >> Will review/test it asap on my efikamx. thanks for working on this :)
> >> 
> >> >
> >> > Signed-off-by: Yong Shen <yong.shen@linaro.org>
> >> > ---
> >> >  drivers/mfd/Kconfig                   |    4 +
> >> >  drivers/regulator/Kconfig             |    8 +
> >> >  drivers/regulator/Makefile            |    1 +
> >> >  drivers/regulator/mc13892-regulator.c |  647 +++++++++++++++++++++++++++++++++
> >> >  include/linux/mfd/mc13892.h           |   38 ++
> >> >  5 files changed, 698 insertions(+), 0 deletions(-)
> >> >  create mode 100644 drivers/regulator/mc13892-regulator.c
> >> >  create mode 100644 include/linux/mfd/mc13892.h
> >> 
> >> [...]
> >> 
> >> > +
> >> > +static const int mc13892_vvideo[] = {
> >> > +	2500000, 2600000, 270000, 2775000,
> >> > +};
> >> 
> >> Should be :
> >> static const int mc13892_vvideo[] = {
> >>         270000, 2775000, 2500000, 2600000,
> >> };
> >> 
> >> I've spotted this in my code some time ago. VVIDEO voltages are not
> >> ascending order.
> >
> > If this is true, also a private get_best_voltage_index have to be
> > developed for it.
> 
> It _is_ true. That's sure. About get_best_voltage_index, it's working
> fine with it as it doesn't care about voltage order afaik. See the
> comment in the get_best_voltage_index() function.

Yes, I'm getting wired today.
get_best_voltage_index find the minimum value within the array that is
>= min_uV.


-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
