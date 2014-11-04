From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 04 Nov 2014 12:25:14 +0000
Subject: [PATCH v3 11/19] arm/arm64: KVM: refactor MMIO accessors
In-Reply-To: <20141104115543.GM16132@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-12-git-send-email-andre.przywara@arm.com>
 <20141104115543.GM16132@cbox>
Message-ID: <5458C5AA.2070207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/11/14 11:55, Christoffer Dall wrote:
> On Fri, Oct 31, 2014 at 05:26:46PM +0000, Andre Przywara wrote:
>> The MMIO accessors for GICD_I[CS]ENABLER, GICD_I[CS]PENDR and
>> GICD_ICFGR behave very similar in GICv3, although the way the
>> affected vCPU is determined differs.
> 
> They behave similarly to each other (the registers) or similarly to how
> they are implemented for GICv2?

Similarly to GICv2. Actually we have _three_ places where we need to
handle them: for the GICv2 distributor, for the GICv3 distributor
(handling only SPIs) and for the GICv3 redistributor (caring about PPIs
and SGIs). So I didn't want to have very similar code at three places,
thus the refactoring.

>> Factor out a generic, backend-facing implementation and use small
>> wrappers in the current GICv2 emulation to ease code sharing later.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> I can't really understand the motivation from your commit message, but
> the code looks fine and I suppose I'll realize the motivation later:

Hopefully the actual GICv3 emulation code will provide that insight. I
can add the above explanation to the commit message to make this more
obvious.

> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks!
Andre
