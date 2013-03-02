From: bilhuang@nvidia.com (Bill Huang)
Date: Fri, 1 Mar 2013 18:58:18 -0800
Subject: [PATCH 2/5] clk: notifier handler for dynamic voltage scaling
In-Reply-To: <5131143D.2060904@wwwdotorg.org>
References: <1362026969-11457-1-git-send-email-mturquette@linaro.org>
 <1362026969-11457-3-git-send-email-mturquette@linaro.org>
 <1362130891.19498.12.camel@bilhuang-vm1> <5131143D.2060904@wwwdotorg.org>
Message-ID: <1362193098.2407.27.camel@bilhuang-vm1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-03-02 at 04:49 +0800, Stephen Warren wrote:
> On 03/01/2013 02:41 AM, Bill Huang wrote:
> > On Thu, 2013-02-28 at 12:49 +0800, Mike Turquette wrote:
> >> There are three prerequisites to using this feature:
> >>
> >> 1) the affected clocks must be using the common clk framework
> >> 2) voltage must be scaled using the regulator framework
> >> 3) clock frequency and regulator voltage values must be paired via the
> >> OPP library
> > 
> > Just a note, Tegra Core won't meet prerequisite #3 since each regulator
> > voltage values is associated with clocks driving those many sub-HW
> > blocks in it.
> 
> Perhaps that "just" means extending the dvfs.c code here to iterate over
> each clock consumer (rather than each clock provider), and having each
> set a minimum voltage (rather than a specific voltage), and having the
> regulator core apply the maximum of those minimum constraints?
> 
> Or something like that anyway.

Thanks, I'll think about this or maybe study a bit, it sounds like we
can leverage existing api in regulator framework (which I don't know) to
do what you've proposed, please clarify if I misunderstand.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
