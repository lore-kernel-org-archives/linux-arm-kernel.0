From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Dec 2012 18:18:40 +0000
Subject: Coresight bus and drivers from CodeAurora
In-Reply-To: <CACRpkdYeFw3YqYqgNAKUv1U4edyzzUa9x6xBSoBU4BbBoc6q5Q@mail.gmail.com>
References: <CACRpkdYeFw3YqYqgNAKUv1U4edyzzUa9x6xBSoBU4BbBoc6q5Q@mail.gmail.com>
Message-ID: <20121210181840.GI12030@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Dec 10, 2012 at 12:40:20PM +0000, Linus Walleij wrote:
> recently my colleague Magnus (@ST-Ericsson) found this bus and
> implementations for the ARM Coresight and drivers for the ARM Coresight
> blocks ETB, ETM, Funnel, Replicator, STM, TMC and TPIU. The
> code is here:
> https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=tree;f=drivers/coresight;h=f0221ea9a55c1e8bcd63f36ec28abb6d5406e63d;hb=refs/heads/msm-3.4
> 
> What is your intention with this? Do you have any intention to mainline?
> 
> We can see it has references to Qualcomm in the device tree strings even
> though they are ARM Coresight HW blocks, for example, so some changes
> are likely necessary, and such bindings should pass the devicetree-discuss
> list.
> 
> Will: what is ARM Ltd. position on these blocks and their drivers? Any plans
> from your side?
>

>From what I understand, ARM has looked at the idea of self-hosted tracing
using Coresight but we couldn't find a compelling use-case and, as such,
don't currently have any plans in this area.

That's not to say it's been written off if somebody has good use for it.
What exactly is your use-case and why is there yet another driver on the
cards? I have some personal opinions about what we should/shouldn't do in
this space, but that can come later.

> The design is nice, but maybe this is one of the few cases where the
> drivers should actually live under arch/arm/common/* or similar.

Well, if the code is useful on arm64 then a directory outside of arch/ could
be beneficial.

Cheers,

Will
