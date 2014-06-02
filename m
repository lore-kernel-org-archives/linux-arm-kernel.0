From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 2 Jun 2014 15:43:02 -0500
Subject: [PATCH 1/2] pci: Add IORESOURCE_BIT entry for PCIe ECAM resources.
In-Reply-To: <4495090.ktpdXEyibD@wuerfel>
References: <20140530233034.GH1677@bart.dudau.co.uk>
 <20140602162306.4AB0FC40476@trevor.secretlab.ca>
 <2F6515B1-48FE-4ED6-908E-CC1CAD7AF403@codeaurora.org>
 <4495090.ktpdXEyibD@wuerfel>
Message-ID: <95C66A63-9671-4AD5-9804-6647A305DB99@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jun 2, 2014, at 2:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 02 June 2014 13:09:08 Kumar Gala wrote:
>>> However, what do we do with the 2 cases that exist in upstream that
>>>> are using ranges for cfg space?
>>> 
>>> Ignore them in the core code? Make the specific host controller handle
>>> them I would think.
>> 
>> I just meant, should we ?break? their DTs and move them from using ranges to reg?
> 
> dw-pcie is used on a lot of systems, I think we should make the common
> part of that driver always handle config space in a common way, and
> move out the part that parses the ranges property into the individual
> soc-specific glue drivers that want to keep optional backwards compatibility
> with existing dtbs.
> 
> Which one is the other driver?
> 
> 	Arnd

Its imx6 and exynos, havent looked to see if dw-pcie is handling the parsing or not for them.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
