From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 2 Nov 2017 12:06:24 -0700
Subject: [PATCH 00/12] bcm63xx-rng conversion to bcm2835-rng
In-Reply-To: <1329593033.127526.1509649260041@email.1und1.de>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
 <1329593033.127526.1509649260041@email.1und1.de>
Message-ID: <cf0cc77c-6114-74d3-2342-b9c4a55f6800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 11/02/2017 12:01 PM, Stefan Wahren wrote:
> Hi Florian,
> 
>> Florian Fainelli <f.fainelli@gmail.com> hat am 2. November 2017 um 02:03 geschrieben:
>>
>>
>> Hi,
>>
>> As it usually happens when there is a fair amount of HW IP block re-use,
>> competing implementations show up. In that case the BCM2835 HWRNG driver and
>> the BCM63xx RNG driver have exactly the same register offsets and this is
>> indeed the same piece of HW.
>>
>> This patch series first prepares the bcm2835-rng to be more future proof and
>> support newer platforms, and the last part brings in what is necessary to
>> migrate the bcm63xx-rng over to bcm2835-rng. Finally we delete bcm63xx-rng
>> completely.
>>
>> The reason why BCM2835 RNG was kept over BCM63xx RNG is because the former
>> deals correctly with a warm up count and the number of words available in the
>> FIFO size.
> 
> are these the same patches as in this branch [1]?
> 
> https://github.com/ffainelli/linux/commits/rng-consolidation

Yes, this branch contains these 12 patches.
-- 
Florian
