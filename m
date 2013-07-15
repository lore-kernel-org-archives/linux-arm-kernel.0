From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 15 Jul 2013 22:58:09 +0530
Subject: [PATCH V2] ARM: tegra: enable palmas device for dalmore
In-Reply-To: <51E427D6.7090702@wwwdotorg.org>
References: <1373441852-27176-1-git-send-email-ldewangan@nvidia.com>
 <51E427D6.7090702@wwwdotorg.org>
Message-ID: <51E43129.7080602@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 July 2013 10:18 PM, Stephen Warren wrote:
> On 07/10/2013 01:37 AM, Laxman Dewangan wrote:
>> Make the entry of Dalmore Power Management Unit device TPS65913
>> in dalmore DTS file. The Palma driver support this device.
>>
>> Enable following submodule of the TPS65913:
>> - GPIO driver
>> - RTC driver.
>> - Power regulator driver.
> If I apply this, (at least) the SD card no longer works. I assume the
> regulator for it is being turned off somehow.

As per downstream power tree, smps9 is feeding power to sd slot and I 
make this rail as always ON. So there should not be any issue.

Rhyland,
Do you see any differences on this power tree with your power tree with 
DT? There was discussion sometime ago on the sdcard. Am I missing 
anything here?

Thanks,
Laxman
