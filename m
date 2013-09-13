From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 13 Sep 2013 15:40:02 +0100
Subject: [Question] Verification For arm64: suspend/resume implementation
In-Reply-To: <52327E41.1070904@marvell.com>
References: <52327E41.1070904@marvell.com>
Message-ID: <20130913144001.GA28531@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 03:53:53AM +0100, Leo Yan wrote:
> hi Lorenzo,
> 
> I have applied your ARM64's suspend/resume related patches and can built 
> successfully. i want to verify these patches on foundation model 
> firstly, so below are my questions:
> 
> "Code has been tested on AEM v8 models and a simple CPU idle driver that 
> enables a C-state where CPUs are reset when wfi is hit."
> 
> 1. Can u help share this simple cpu idle driver?

Yes, I will post a simple skeleton driver, PSCI based (bootwrapper
implementation), by the end of September.

> 2. On the foundation model, if the core is placed into reset state, then 
> if there have interrupt is routed to the core, the core still cannot be 
> waken up anymore; because the reset bit cannot be released by h/w. So 
> how can let the core return back from the reset state?

Well, I am testing it with the AEM models power controller that is not
publicly available yet, and _should_ be released with the new version of the
foundation models.

As a first step, I will write a PSCI suspend implementation that just executes
wfi and resumes through the reset vector to emulate a power down as a means to
make the suspend/resume code path usable to everyone.

Lorenzo
