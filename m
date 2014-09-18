From: florian@openwrt.org (Florian Fainelli)
Date: Thu, 18 Sep 2014 15:39:18 -0700
Subject: [PATCH 0/6] Add initial support for Broadcom Cygnus SoC
In-Reply-To: <541B5D5A.10800@hauke-m.de>
References: <Jonathan Richardson <jonathar@broadcom.com>
 <1410897497-27527-1-git-send-email-jonathar@broadcom.com>
 <541B5D5A.10800@hauke-m.de>
Message-ID: <541B5F16.6030005@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2014 03:31 PM, Hauke Mehrtens wrote:
> On 09/16/2014 09:58 PM, Jonathan Richardson wrote:
>> Hi,
>>
>> This patchset contains initial support for Broadcom's Cygnus SoC based on our
>> iProc architecture. Initial support is minimal and includes just the mach
>> platform code, clock driver, and a basic device tree configuration. Peripheral
>> drivers will be submitted soon, as will device tree configurations for other
>> Cygnus board variants.
> 
> This SoC looks similar to the BCM5301X (Northstar) SoCs even some cores
> are at the same memory addresses. Does this SoC use an AXI bus with
> Broadcom Plugins at address 0x18000000 ?
> 
> The BCM5301X (Northstar) SoCs also has an iProc Clock Control Unit and I
> will try to use your driver for that SoC.
> 
> Is Broadcom Cygnus similar to BCM563XX or is it actually the same SoC?

According to this link:
http://lists.denx.de/pipermail/u-boot/2014-August/186086.html

these SoCs, in particular BCM58622 would belong to the StrataGX network
processors:
http://www.broadcom.com/products/Processors/Home-and-Small-Business/BCM5862X-Series.

> 
> Do you have some description of the hardware features of this SoC? Does
> it have PCIe, or Ethernet?

>From the link above, it has Ethernet for sure, and certainly PCIe since
the Wi-Fi chips mentioned in the link above are PCIe chips.

It would be really good if all the work you and Rafal did was usable for
the Cygnus SoCs.
--
Florian
