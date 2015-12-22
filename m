From: jcm@redhat.com (Jon Masters)
Date: Tue, 22 Dec 2015 11:45:20 -0500
Subject: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
In-Reply-To: <56797C16.2020802@redhat.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
 <201512211510.32029.arnd@arndb.de>
 <335CDE2E-B588-43A8-8665-6023AFD0EA04@redhat.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC17CAC@lhreml503-mbb>
 <56797C16.2020802@redhat.com>
Message-ID: <56797E20.2080107@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2015 11:36 AM, Jon Masters wrote:
> On 12/22/2015 04:29 AM, Gabriele Paoloni wrote:
>> Hi Jon, thanks for replying
>>
>>> -----Original Message-----
>>> From: Jon Masters [mailto:jcm at redhat.com]
>>> Sent: 21 December 2015 23:11
>>> To: Arnd Bergmann
>>> Cc: Gabriele Paoloni; Tomasz Nowicki; bhelgaas at google.com;
>>> will.deacon at arm.com; catalin.marinas at arm.com; rjw at rjwysocki.net;
>>> hanjun.guo at linaro.org; Lorenzo.Pieralisi at arm.com; okaya at codeaurora.org;
>>> jiang.liu at linux.intel.com; Stefano.Stabellini at eu.citrix.com;
>>> robert.richter at caviumnetworks.com; mw at semihalf.com; Liviu.Dudau at arm.com;
>>> ddaney at caviumnetworks.com; tglx at linutronix.de; Wangyijing;
>>> Suravee.Suthikulpanit at amd.com; msalter at redhat.com; linux-
>>> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
>>> acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linaro-
>>> acpi at lists.linaro.org; jchandra at broadcom.com
>>> Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space
>>> accessors against platfrom specific quirks.
>>>
>>> Sorry for top-posting. A quick note that SMBIOS3 is required by SBBR so
>>> it can be presumed that compliant platforms will provide quirks via DMI.
>>
>> Ok so you completely clarified my question 1). Many Thanks for this
> 
> No problem. One of the (many) reasons I pushed for requiring SMBIOS/DMI
> in SBBR (I was lead author of one of the early drafts of that document)
> was to make the experience ultimately equivalent across architectures.
> We already know how to do quirks and handle platform deviations, and the
> major Operating System vendors did not want to reinvent the wheel.

Additional: it is clear that more prescription is required to get the
vendors onto the bandwagon that we have with other architectures (e.g.
that other one). So there will be a Red Hat "ARM server whitepaper"
coming in the early new year that will include the kind of "server 101"
material we want to make sure people know. Things like making sure you
implement and test PCIe correctly, handle backward compatibility (you
will build hardware in the future that runs my existing OS release),
design the hardware to allow for workarounds later, etc. I expect some
other Operating System vendors to be involved in reviewing that.

Ultimately my objective is to make this whole thing dull and boring. You
will get RHEL(SA)/upstream kernels and it will either boot or it will
not. If it does not boot, vendor X screwed up their hardware. We know
this story, it's been this way for over a decade already, and that is
exactly how it is going to be with ARM servers shortly.

Jon.
