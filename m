From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Jul 2012 14:36:49 -0600
Subject: [PATCH 03/15] ARM: tegra: use fixed PCI i/o mapping
In-Reply-To: <4FF74789.8000804@wwwdotorg.org>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <1341600040-30993-4-git-send-email-robherring2@gmail.com>
 <4FF74028.6090300@wwwdotorg.org> <4FF74689.8070103@gmail.com>
 <4FF74789.8000804@wwwdotorg.org>
Message-ID: <4FF74C61.4060903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2012 02:16 PM, Stephen Warren wrote:
> On 07/06/2012 02:11 PM, Rob Herring wrote:
>> On 07/06/2012 02:44 PM, Stephen Warren wrote:
>>> On 07/06/2012 12:40 PM, Rob Herring wrote:
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> Move tegra PCI to fixed i/o mapping and remove io.h.
>>>
>>> Thierry, since you're the Tegra PCIe expert right now, could you please
>>> test and/or comment on this.
>>>
>>> I did try testing this on next-20120705 on TrimSlice (i.e. the
>>> PCIe-based Ethernet controller), but found that PCIe has stopped working
>>> there due to "resource collisions". I know this used to work fairly
>>> recently, since I tested it when I added the PCIe initialization call to
>>> board-dt-tegra20.c. The PCIe messages are:
>>
>> This is with my change and it works currently without?
> 
> Sorry, no, it's broken even without your change. Hence, I can't test the
> impact of your change. Well, I saw the same failure with your patches
> too, but that isn't really conclusive testing of your change:-)

Aha. The PCIe problem only shows up when booting TrimSlice using DT (in
next-20120705 or Tegra's for-next branch).

When booting using board files, PCIe works, both without and with your
patch, on top of next-20120705.

So, your patches are tested on Tegra and still working.
