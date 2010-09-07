From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Sep 2010 06:12:50 +0200
Subject: [PATCH 16/74] ST SPEAr: adding support for synopsis i2c designware
In-Reply-To: <4C85B94E.3040307@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<72ad657ab3eb9d61f11741145494eadb061926b9.1283161023.git.viresh.kumar@st.com>
	<20100906231227.GG8153@game.jcrosoft.org> <4C85B94E.3040307@st.com>
Message-ID: <20100907041250.GC30509@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:32 Tue 07 Sep     , viresh kumar wrote:
> Jean,
> 
> Thanks for reviewing our patches. Really appreciate your effort.
> 
> On 9/7/2010 4:42 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> > @@ -501,6 +510,9 @@ static struct clk_lookup spear_clk_lookups[] = {
> >> >  	{ .dev_id = "adc",		.clk = &adc_clk},
> >> >  	{ .dev_id = "ssp",		.clk = &ssp_clk},
> >> >  	{ .dev_id = "gpio",		.clk = &gpio_clk},
> >> > +#ifdef CONFIG_MACH_SPEAR320
> >> > +	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
> >> > +#endif
> > how about split this file in 2
> > one for 320 and one for 310 so we can avoid all this ifdef
> 
> There was a mistake in this patch series. As you can see in the last patches,
> we worked on single image solution for spear*xx family. When we select all
> machines then all clocks are getting registered. which is wrong?
> 
> I have corrected it in my local repo. Now i have created clk_lookup arrays
> for individual machines and one for common clk structures. So you will not
> find this mess finally in V2 release.

please split your v2 patch series in related changset it will simplify the
review

Best Regards,
J.
