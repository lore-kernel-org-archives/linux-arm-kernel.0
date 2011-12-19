From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 19 Dec 2011 09:03:58 +0800
Subject: [PATCH V2 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <4EEBA306.3060309@codeaurora.org>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>
 <1324031462-24961-2-git-send-email-richard.zhao@linaro.org>
 <20111216105229.GB3230@totoro> <4EEBA306.3060309@codeaurora.org>
Message-ID: <20111219010357.GW28768@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

On Fri, Dec 16, 2011 at 11:59:02AM -0800, Bryan Huntsman wrote:
> On 12/16/2011 02:52 AM, Jamie Iles wrote:
> >
> >> +static DEFINE_PER_CPU(unsigned long, l_p_j_ref);
> >> +static unsigned long l_p_j_ref_freq;
> >> +
> >> +static struct clk *cpu_clk;
> > 
> > This assumes that all CPU's share the same clk and run at the same rate.  
> > Is that a fair/safe assumption?  I honestly don't know the answer to 
> > this so it's just a question!!!
> 
> On MSM, cpus independently scale both frequency and voltage.  Our clock
> driver isn't upstream yet.  David Brown has a preliminary version here:
> 
> https://www.codeaurora.org/gitweb/quic/kernel/?p=davidb/linux-msm.git;a=shortlog;h=refs/heads/msm-clock-rfc
> 
> Once we get our driver upstream, MSM will be an exception and not select
> ARM_GENERIC_CPUFREQ.  We'll probably have a separate msm-cpufreq.c
> driver under drivers/cpufreq/.
Do you have to patch to implement per-cpu udelay? In current code, udelay uses
global loops_per_jiffy.

Thanks
Richard
> 
> - Bryan
> 
> -- 
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
