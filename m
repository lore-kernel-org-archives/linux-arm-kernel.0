From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 2 Jun 2014 10:40:30 -0500
Subject: [PATCH 1/2] pci: Add IORESOURCE_BIT entry for PCIe ECAM resources.
In-Reply-To: <20140602150945.964D4C40381@trevor.secretlab.ca>
References: <20140530233034.GH1677@bart.dudau.co.uk>
 <1401496601-31983-1-git-send-email-Liviu.Dudau@arm.com>
 <1401496601-31983-2-git-send-email-Liviu.Dudau@arm.com>
 <4756033.LkcFQN0chs@wuerfel> <20140602150945.964D4C40381@trevor.secretlab.ca>
Message-ID: <390B3F94-C058-47D6-82CE-0393E60014FF@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jun 2, 2014, at 10:09 AM, Grant Likely <grant.likely@linaro.org> wrote:

> On Sat, 31 May 2014 20:41:04 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Saturday 31 May 2014 01:36:40 Liviu Dudau wrote:
>>> We would like to be able to describe PCIe ECAM resources as
>>> IORESOURCE_MEM blocks while distinguish them from standard
>>> memory resources. Add an IORESOURCE_BIT entry for this case.
>>> 
>>> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>> 
>> I still don't see any value in this at all. What is the advantage
>> of doing this opposed to just having a standardized 'reg' property
>> for a particular compatible string?
> 
> I'm inclined to agree. It doesn't seem appropriate to put config space
> in ranges, and the host controller binding is responsible for
> identifying how config space is memory mapped.
> 
> g.

I don?t agree when it comes to ECAM, but we can drop this for now until someone really does that.

However, what do we do with the 2 cases that exist in upstream that are using ranges for cfg space?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
