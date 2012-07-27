From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Jul 2012 10:13:04 +0800
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120726131121.GB7306@sirena.org.uk>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <20120726131121.GB7306@sirena.org.uk>
Message-ID: <20120727021303.GB3347@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 02:11:21PM +0100, Mark Brown wrote:
> On Thu, Jul 19, 2012 at 11:54:41PM +0800, Shawn Guo wrote:
> 
> > +Optional properties:
> > +- transition-latency: Specify the possible maximum transition latency,
> > +  in unit of nanoseconds.
> 
> This should make it clear that the transition latency being documented
> here is just that for the core clock change itself, there may be other
> sources of latency like the regulator ramp time or reprogramming PLLs.
I think it's the total time and board dts can over-write it if it
needs. Different transitions between different operating points may
differ, and regulator may be able to indicate the transition time but
clk don't have such api, and probably not worth to have.
 
Thanks
Richard
