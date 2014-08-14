From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 14 Aug 2014 11:47:57 -0400 (EDT)
Subject: [PATCH v7 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
In-Reply-To: <20140814112911.GA5039@red-moon>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-4-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1408131223501.1133@knanqh.ubzr>
 <20140813170440.GA30822@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1408131319210.1133@knanqh.ubzr>
 <20140814112911.GA5039@red-moon>
Message-ID: <alpine.LFD.2.11.1408141142530.29347@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Aug 2014, Lorenzo Pieralisi wrote:

> On Wed, Aug 13, 2014 at 06:29:49PM +0100, Nicolas Pitre wrote:
> > So if you tell me a messed-up DT won't bear much consequences then I'm 
> > fine with that.
> 
> Nico, on second thoughts, since Ashwin raised the point too and I think
> that at these early stages it might turn out useful, I gave coding
> the check a go. I tried to make the check self contained so that we can
> yank it out if we do not want it in the final version or we will want
> to remove it later.
> 
> Here the refreshed patch is:
> 
> -- >8 --
> Subject: [PATCH] drivers: cpuidle: implement DT based idle states
>  infrastructure
> 
> On most common ARM systems, the low-power states a CPU can be put into are
> not discoverable in HW and require device tree bindings to describe
> power down suspend operations and idle states parameters.
> 
> In order to enable DT based idle states and configure idle drivers, this
> patch implements the bulk infrastructure required to parse the device tree
> idle states bindings and initialize the corresponding CPUidle driver states
> data.
> 
> The parsing API accepts a start index that defines the first idle state
> that should be initialized by the parsing code in order to give new and
> legacy driver flexibility over which states should be parsed using the
> new DT mechanism.
> 
> The idle states list is obtained from the first cpu in the driver
> cpumask, which implicitly means the parsing code expects idle states
> (and related list of phandles) to be the same for all CPUs in the
> CPUidle driver mask. The kernel does not check this assumption, it must
> be enforced by the bootloader to ensure correct system behaviour.

Is this last sentence still true?


Nicolas
