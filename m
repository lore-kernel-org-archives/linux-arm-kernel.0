From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Sat, 02 Jun 2018 13:57:19 -0400
Subject: [PATCH] PCI: Add pci=safemode option
In-Reply-To: <20180602174307.GB14870@amd>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
 <20180530043103.GA19734@kroah.com>
 <6c317ed8-cca3-8862-5f3b-12cf14e4d53b@codeaurora.org>
 <20180602174307.GB14870@amd>
Message-ID: <f3d6c44829910cb09c6f72dba1c41b39@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-06-02 13:43, Pavel Machek wrote:
> Hi!
> 
>> > And you should explain what exactly in PCI is "optional".  Who defines
>> > this and where is that list and what can go wrong if those options are
>> > not enabled?
>> 
>> Bjorn and I discussed the need for such a "safe" mode feature when you
>> want to bring up PCI for a platform. You want to turn off everything 
>> as
>> a starter and just stick to bare minimum.
>> 
>> I can add a few words describing them. The goal of this option is to 
>> keep
>> base PCI features with MSI only. Things like PME, AER, ASPM, Extended
>> Tags, LTR, Relaxed Ordering, SRIOV are all considered optional. 
>> safemode
>> is certainly not intended for production environments.
>> 
>> I can taint the kernel as a suggestion.
> 
> I don't think tainting is required. even modern platforms should work
> in the safe mode.

Yeah, concern was getting used to the safe mode and never running the 
full stack to fix the actual issues like getting away with crappy 
hardware and firmware.

It becomes a support issue for the community.


> 									Pavel
