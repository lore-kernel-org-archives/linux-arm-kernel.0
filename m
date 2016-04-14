From: jcm@jonmasters.org (Jon Masters)
Date: Thu, 14 Apr 2016 01:55:32 -0400
Subject: [PATCH v2 2/4] PCI: Provide common functions for ECAM mapping
In-Reply-To: <20160412164413.GA32297@red-moon>
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
 <1460414707-19153-3-git-send-email-jchandra@broadcom.com>
 <570C4034.20105@caviumnetworks.com> <570C78F1.4090701@jonmasters.org>
 <20160412164413.GA32297@red-moon>
Message-ID: <570F30D4.2030102@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2016 12:44 PM, Lorenzo Pieralisi wrote:
> On Tue, Apr 12, 2016 at 12:26:25AM -0400, Jon Masters wrote:
> 
> [...]
> 
>> Quoting Bjorn's original reply to the previous series:
>>
>>> Some of the code that moved to drivers/acpi/pci_mcfg.c is not
>>> really ACPI-specific, and could potentially be used for non-ACPI
>>> bridges that support ECAM.  I'd like to see that sort of code
>>> moved to a new file like drivers/pci/ecam.c.
>>
>> So my guess is that this is the reasoning behind JC's file layout.
>>
>> I'm curious what Lorenzo's take on things is currently. I assume this
>> series is now to be the official coordinated version of this effort for
>> upstream, following the advice of Bjorn previously, but I would like to
>> know if everyone is behind this plan. I've (previously) requested a
>> Linaro LEG meeting this week (part of our bootarch working group) to
>> specifically discuss the status of PCI upstreaming in order to get the
>> different vendors together to ensure every single one of them is
>> tracking the correct latest effort and doing what is needed to test/aid,
>> hence my ask. If this is now plan A, I'll make sure everyone is aligned
>> behind it and start pinging people individually for testing.
> 
> My take is that JC's aim is to get this four patch series reviewed and
> merged

Indeed, I see that's probably the goal, and why not :)

> (which is *not* sufficient to get ACPI PCI to work fully on ARM64
> - see cover letter - the remaining patches in his branch are not
> fixes, it is code that is required to get things to work, these 4
> patches stand alone are not sufficient but I understand he wants to get
> them reviewed following feedback on the lists) so that we can make
> progress on ACPI PCI on ARM64.

Agreed. I went through the branch and the 11 patches there, reacquainted
myself with what's what. So what we have now is 4 patches here plus a
few others that in total replace v5 of your previous mmconfig patches in
functionality. The question is what happens with the rest (of JC's
branch let's say) - do they get sent out now too?

> I will comment on the patches as soon as I have time to review
> them, I certainly would like to understand what we have to do with the
> rest of the code though (provided this series is good to go) see above.

Right. That's my reason for asking. I'd like to know who is driving (I
believe that to be Lorenzo) and what the path forward is, and whether we
need to get additional support from anyone else. There's a multi-vendor
meeting in the morning where I'm going to summarize the current state of
these patches and I would like to know (soon) what the plan is so that
we can get everyone on deck to help out at least with testing (most have
tested the previous set, but we need public acks happening).

Jon.
