From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 17 Dec 2010 03:09:18 -0800 (PST)
Subject: [PATCH] arm: dma-mapping: move consistent_init to early_initcall
In-Reply-To: <20101217105657.GB9937@n2100.arm.linux.org.uk>
References: <4CFDD297.4020600@codeaurora.org>
	<15d23d63900e4545a40555961c49c421.squirrel@codeaurora.org>
	<20101209103835.GA31465@n2100.arm.linux.org.uk>
	<4D017B45.4000805@codeaurora.org>
	<AANLkTi=PnnT8rVKMxK0tVTdKnKdcKf71fsX2o594Qx3e@mail.gmail.com>
	<4D045692.4050607@codeaurora.org>
	<AANLkTimwqC6DqN8ft10EyRbPh9XvibN1fA-Cug4OdS5m@mail.gmail.com>
	<8c67e174d807416f0c6c190cc72d3f5a.squirrel@www.codeaurora.org>
	<20101217094818.GA9937@n2100.arm.linux.org.uk>
	<99eb693af85e07b01d81d45f1bc77f64.squirrel@www.codeaurora.org>
	<20101217105657.GB9937@n2100.arm.linux.org.uk>
Message-ID: <6149a450170fa5fe32b271d2db0ec81b.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Fri, Dec 17, 2010 at 02:26:44AM -0800, Saravana Kannan wrote:
>> After Catalin's response to clarify, if we still end up not treating
>> secure domain as a "DMA device", then what's the alternative? Can we get
>> an explicit "cache invalidate API" that's outside of the DMA APIs? Or a
>> general uncached pages alloc/free APIs?
>
> The answer _always_ is that if the existing APIs don't give you want
> you need, then either the APIs need extending or a new API needs to
> be created.

I will wait to hear Catalin's clarification before I proceed further with
this point.

>
> In any case, have you looked at the latest set of SCM patches?  They
> don't make use of DMA coherent memory anymore, so the problem would
> seem to be resolved.
>

Yes, I saw them and even pointed out a few issues during internal-prelim
review. The new patches get around it with what we hope is a temporary
solution -- implement cache invalidate in assembly and call it over a
kmalloc'ed and page aligned memory.

-Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
