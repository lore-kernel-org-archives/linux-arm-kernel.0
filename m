From: jhnikula@gmail.com (Jarkko Nikula)
Date: Fri, 1 Jul 2011 17:05:17 +0300
Subject: [RFC 07/12] omap: mcbsp: Get rid of remaining is_omap tests
In-Reply-To: <CA+HSevrUgP8pKNjSgkpDB6hUX=cvCUOU8mpU2Ca5qa75Rnp36w@mail.gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
	<1309510356-27147-8-git-send-email-jhnikula@gmail.com>
	<CA+HSevrUgP8pKNjSgkpDB6hUX=cvCUOU8mpU2Ca5qa75Rnp36w@mail.gmail.com>
Message-ID: <20110701170517.8b13c94d.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 1 Jul 2011 16:41:23 +0530
"Varadarajan, Charulatha" <charu@ti.com> wrote:

> > @@ -712,7 +710,7 @@ static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
> > ? ? ? ?/*
> > ? ? ? ? * Disable wakup behavior, smart idle and all wakeups
> > ? ? ? ? */
> > - ? ? ? if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> > + ? ? ? if (mcbsp->mcbsp_config_type >= MCBSP_CONFIG_TYPE3) {
> 
> 
> I think that it would be a good idea to not use
> MCBSP_CONFIG_TYPE* in plat-omap/* as it is the .rev info.
> At later point of time, this might make the code look uglier
> as it happened with GPIO_METHOD_* flags in OMAP GPIO driver.
> Instead use this .rev info in mach-omap*/ to fill the pdata and pass it
> to driver.
> 
Exactly and this is already a little uggly here. Kind of simple
replacement for cpu_is_omap tests and definitely must be replaced with
some feature flags before moving code outside of plat-omap.

-- 
Jarkko
