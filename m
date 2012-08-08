From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Aug 2012 08:35:19 +0100
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <20120807170333.GV16861@opensource.wolfsonmicro.com>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
 <20120806081915.GA4518@core.coreip.homeip.net>
 <20120806153750.GI10524@gmail.com>
 <20120806160226.GF29272@sirena.org.uk>
 <20120807170129.GA3759@gmail.com>
 <20120807170333.GV16861@opensource.wolfsonmicro.com>
Message-ID: <20120808073518.GA4728@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Restating my comment elsewhere...  why do we even need to do this in
> _get_virq() - I'd *really* expect this to be handled by the irq domain
> code.

> > Okay, so I've just spent a small amount of time looking at this. I think
> > the best place for this would be in *_get_virq(), using the same logic that
> > selected a *_legacy or *_linear domain in the first place. 

> I'd expect your driver to always pass a hwirq into _get_virq() here.

I actually had this thought last night.

(I really must learn to switch off in the evenings.) ;)

That's even easier then. I'll make the changes and submit.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
