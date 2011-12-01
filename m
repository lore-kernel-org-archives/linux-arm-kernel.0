From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Dec 2011 18:32:11 +0000
Subject: [PATCH v3 3/5] clk: introduce the common clock framework
In-Reply-To: <alpine.DEB.2.00.1112011124221.6289@utopia.booyaka.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-4-git-send-email-mturquette@linaro.org>
 <alpine.DEB.2.00.1111291619110.6289@utopia.booyaka.com>
 <CAJOA=zM4vcyTt_RBEVm6JxmzW-Dna0gpuWda7ytq_mqFSuXw9g@mail.gmail.com>
 <alpine.DEB.2.00.1111302308280.6289@utopia.booyaka.com>
 <20111201144205.GA2103@sirena.org.uk>
 <alpine.DEB.2.00.1112011124221.6289@utopia.booyaka.com>
Message-ID: <20111201183211.GC18120@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 11:30:16AM -0700, Paul Walmsley wrote:

> So for example, if you had a driver that did:

> c = clk_get(dev, clk_name);
> clk_enable(c);
> clk_set_rate(c, clk_rate);

> and c was currently not enabled by any other driver on the system, and 
> nothing else had called clk_block_rate_change(c), then the rate change 
> would be allowed to proceed.  (modulo any notifier activity, etc.)  

> So clk_{allow,block}_rate_change() was simply intended to allow or 
> restrict other users of the same clock, not the current user.

Ah, sorry!  I'd totally misunderstood what you were proposing.
