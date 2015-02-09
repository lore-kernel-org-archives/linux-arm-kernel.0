From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 09 Feb 2015 13:27:58 -0800
Subject: [PATCH/RFC 0/4] Probe deferral for IOMMU DT integration
In-Reply-To: <2115835102.210232.1423348884955.JavaMail.open-xchange@oxbaltgw04.schlund.de>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
 <2115835102.210232.1423348884955.JavaMail.open-xchange@oxbaltgw04.schlund.de>
Message-ID: <54D9265E.1030403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/7/2015 2:41 PM, arnd at arndb.de wrote:
> Laura Abbott <lauraa@codeaurora.org> hat am 6. Februar 2015 um 01:31
> geschrieben:
>>
>> The requirement for this is based on a previous patch to add clock
>> support to the ARM SMMU driver[2]. Once we have clock support, it's
>> possible that the driver itself may need to be defered which breaks
>> a bunch of assumptions about how SMMU probing is supposed to work.
>
> Hi Laura,
>
> I was hoping that we would not need this, and instead treat the iommu in
> the same way as timers and SMP initialization, both
> of which need to be run early at boot time but may rely on clock controllers
> to be initialized first.
>
> Is there a specific requirement that makes this impossible here, or is your
> intention to solve the problem more nicely by allowing deferred probing
> over forcing the input clocks of the iommu to be early?
>
>        Arnd
>

The current clock driver for qcom targets doesn't support the early
initialization needed for timers and SMP because neither of those depend
on the clocksources. I discussed this with Stephen some and adding the
early support would not mesh well with the device/driver design of the
current clock driver so that's not really an option right now.

I do think the deferred probing design is cleaner. Even cleaner would
be a proper bus type but that's a different can of worms.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
