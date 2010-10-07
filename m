From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Thu, 7 Oct 2010 10:40:44 +0300
Subject: [PATCH] cpufreq for freescale mx51
In-Reply-To: <AANLkTi=fh4_19QhB8ArTfiigbPOQSejB=gLPMiEmyXjP@mail.gmail.com>
References: <1285738417-1638-1-git-send-email-yong.shen@linaro.org>
	<20100930104817.GC2526@matterhorn.lan>
	<20101006095111.GV28242@pengutronix.de>
	<AANLkTi=fh4_19QhB8ArTfiigbPOQSejB=gLPMiEmyXjP@mail.gmail.com>
Message-ID: <20101007074044.GG2457@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Oct 07, Yong Shen wrote:
> 
> > > +static struct cpufreq_frequency_table imx_freq_table[4];
> >
> > Three frequencies should be enough for everyone, right? This should be
> > dynamically allocated like in other cpufreq drivers.
> >
> 
> Yes, we only support 3 work points, which is for sure. Actually, we only
> support 2 points on most mx51 chips. I supposed it is ok to use static array
> here.

This can become a common cpufreq driver for all i.MX platforms. We don't know
how many work points will be supported in future versions of the silicon.
That is why a static array is not ok.

I think Sascha was being ironic when he said "Three frequencies should be
enough for everyone, right?" :)

/Amit
