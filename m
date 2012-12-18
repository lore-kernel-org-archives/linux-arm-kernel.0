From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 18 Dec 2012 13:01:00 -0500
Subject: [Xen-devel] [PATCH v2 5/6] ARM: Dummy Virtual Machine platform
 support
In-Reply-To: <20121218131401.GB22139@mudshark.cambridge.arm.com>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-6-git-send-email-will.deacon@arm.com>
 <alpine.DEB.2.02.1212181202310.17523@kaball.uk.xensource.com>
 <20121218131401.GB22139@mudshark.cambridge.arm.com>
Message-ID: <50D0AF5C.1070605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 12/18/2012 08:14 AM, Will Deacon wrote:
> Hi Stefano,
> 
> On Tue, Dec 18, 2012 at 12:04:38PM +0000, Stefano Stabellini wrote:
>> On Mon, 17 Dec 2012, Will Deacon wrote:
>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>
>>> Add support for the smallest, dumbest possible platform, to be
>>> used as a guest for KVM or other hypervisors.

[...]

>> Should it come along with a DTS?
> 
> The only things the platform needs are GIC, timers, memory and a CPU.

I assume multiple virtio-mmio peripherals are hiding behind what you seem to
advertising here as plain old memory?

> Furthermore, the location, size, frequency etc properties of these aren't
> fixed, so a dts would be fairly useless because it will probably not match
> the particular mach-virt instance you're targetting.

I disagree. I think an example DTS would be fairly useful, if only for the
full list of peripherals you're using on the platform.

> For kvmtool, I've been generating the device-tree at runtime based on how
> kvmtool is invoked and it's been working pretty well so far.

If you'd much prefer to post the command line, tools version, etc. that you're
using to generate the DTB, rather than the DTS, that'd be better than nothing.

It seems like Rob Herring's earlier question about whether the dummy platform
is really justified never got answered. I think sending a sample DTS out with
the patchset would help "highlight where we need to do more work on DT driving
the initialization."

Lastly, I'm somewhat curious, why virtio-mmio console rather than DCC?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
