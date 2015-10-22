From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 22 Oct 2015 11:49:53 +0200
Subject: [PATCH 1/2] can: xilinx: use readl/writel instead of
 ioread/iowrite
In-Reply-To: <3847286.pUBWjpC1TL@wuerfel>
References: <1445489163-11045-1-git-send-email-appanad@xilinx.com>
 <4061693.oBld7AKBIp@wuerfel>
 <C246CAC1457055469EF09E3A7AC4E11A4A4F2CDB@XAP-PVEXMBX01.xlnx.xilinx.com>
 <3847286.pUBWjpC1TL@wuerfel>
Message-ID: <5628B141.1010307@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2015 11:02 AM, Arnd Bergmann wrote:
> On Thursday 22 October 2015 08:34:53 Appana Durga Kedareswara Rao wrote:
>>> On Thursday 22 October 2015 10:16:02 Kedareswara rao Appana wrote:
>>>> The driver only supports memory-mapped I/O [by ioremap()], so
>>>> readl/writel is actually the right thing to do, IMO.
>>>> During the validation of this driver or IP on ARM 64-bit processor
>>>> while sending lot of packets observed that the tx packet drop with
>>>> iowrite Putting the barriers for each tx fifo register write fixes
>>>> this issue Instead of barriers using writel also fixed this issue.
>>>>
>>>> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
>>>
>>> The two should really do the same thing: iowrite32() is just a static inline calling
>>> writel() on both ARM32 and ARM64. On which kernel version did you observe the
>>> difference? It's possible that an older version used CONFIG_GENERIC_IOMAP,
>>> which made this slightly more expensive.
>>
>> I observed this issue with the 4.0.0 kernel version
> 
> Is it possible that you have nonstandard patches on your kernel? If so, can
> you send a diff against the mainline version?

Kedar: Can you please retest this on mainline kernel?
We shouldn't have any patches which should influence this.

Thanks,
Michal
