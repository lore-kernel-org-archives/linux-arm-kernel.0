From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 12:31:49 -0600
Subject: [PATCH V2 0/5] ARM: DT: tegra114: Add DT entry for different
 controller
In-Reply-To: <513EFF36.50107@nvidia.com>
References: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
 <513E5771.9000408@wwwdotorg.org> <513EFF36.50107@nvidia.com>
Message-ID: <513F7495.60001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 04:11 AM, Laxman Dewangan wrote:
> On Tuesday 12 March 2013 03:45 AM, Stephen Warren wrote:
>> On 03/09/2013 11:11 AM, Laxman Dewangan wrote:
>>> This patch series add DT entry for APB DMA, I2C, UART, KBC and SPI.
>>>
>>> This patch series is generated on top of CCF work for T114 done by Peter
>>> and hence it should be applied on top of T114 CCF patches.
>>>
>>> Changes from V1:
>>> - Add reeason why APBDMA is not compatible with older driver
>>>    in description.
>>> - Remove UARTB car id correction. Make the compatible with tegra114 and
>>>    older chip.
>>> - Add compatible for kbc as nvidia,tegra114-kbc and nvidia,tegra20-kbc.
>>>
>>> Laxman Dewangan (5):
>>>    ARM: DT: tegra114: add APB DMA controller DT entry
>>>    ARM: DT: tegra114: Add i2c controller DT entry
>>>    ARM: DT: tegra114:add aliases and DMA requestor for serial controller
>>>    ARM: DT: tegra114: add KBC controller DT entry
>>>    ARM: DT: tegra114: Add spi controller DT entry
>> What branch is this series based on? I tried to apply these for testing,
>> but git am failed to apply it to Tegra's for-3.10/dt, and Tegra's
>> for-next, and my local work branch, and next-20130307.
>>
>> Can you please rebase onto Tegra's for-3.10/dt. Thanks.
> 
> I created the patch as:
> - linux next 20130307
> - Then add all clock changes from Peter's
> git://nv-tegra.nvidia.com/user/pdeschrijver/linux.git
> 
> - Then I generated the DT entry on top of this which has clock reference.
> 
> In your 3.10/DT, there is no change for Peter's clock change and
> possibly this is the reason.

Yes, that's probably the problem. Please base on the current for-3.10/dt
branch directly.

> If I base my change on your 3.10/DT then:
> - Do I need to add the clock entry for all modules also?

Yes, please add complete nodes.
