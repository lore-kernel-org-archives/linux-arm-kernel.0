From: abailon@baylibre.com (Alexandre Bailon)
Date: Tue, 6 Dec 2016 10:51:05 +0100
Subject: [PATCH v5] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
In-Reply-To: <2fc7a4ef-02ad-fc15-66ea-9f75756086f8@ti.com>
References: <1480947224-26222-1-git-send-email-abailon@baylibre.com>
 <2fc7a4ef-02ad-fc15-66ea-9f75756086f8@ti.com>
Message-ID: <cbf4b99b-e453-acd5-d864-f709708fbab0@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2016 10:33 AM, Sekhar Nori wrote:
> On Monday 05 December 2016 07:43 PM, Alexandre Bailon wrote:
>> Everytime the usb20 phy is enabled, there is a
>> "sleeping function called from invalid context" BUG.
>>
>> clk_enable() from arch/arm/mach-davinci/clock.c uses spin_lock_irqsave()
>> before to invoke the callback usb20_phy_clk_enable().
>> usb20_phy_clk_enable() uses clk_get() and clk_enable_prepapre()
>> which may sleep.
>> Move clk_get() to da8xx_register_usb20_phy_clk() and
>> replace clk_prepare_enable() by clk_enable().
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> 
> This will still cause the recursive locking problem reported by David.
> Not sure what the point of sending this version was.
> 
> Thanks,
> Sekhar
> 
What am I supposed to do ?

Thanks,
Alexandre
