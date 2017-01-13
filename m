From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jan 2017 17:48:49 +0100
Subject: [PATCH 3/3] rtc: stm32: use 32-bit cast for BIT() macro
In-Reply-To: <26624cbe-7e71-35a4-b8df-f5ac5d15b1ec@st.com>
References: <20170113153311.2611510-1-arnd@arndb.de>
 <20170113153311.2611510-3-arnd@arndb.de>
 <26624cbe-7e71-35a4-b8df-f5ac5d15b1ec@st.com>
Message-ID: <CAK8P3a3vzwB5MDiVse+meK17KKHtaZWzmOkfzJ2d=n=sgjzkRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 4:56 PM, Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
> On 01/13/2017 04:32 PM, Arnd Bergmann wrote:
>>
>> Using the ~ operator on a BIT() constant results in a large 'unsigned
>> long'
>> constant that won't fit into an 'unsigned int' function argument on 64-bit
>> architectures, resulting in a harmless build warning in x86 allmodconfig:
>>
>> drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_probe':
>> drivers/rtc/rtc-stm32.c:651:51: error: large integer implicitly truncated
>> to unsigned type [-Werror=overflow]
>>   regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
>
> I thought I would fix this warning by replacing all ~PWR_CR_DBP by 0,
> because the mask PWR_CR_DBP prevents other bits to be cleared.
> In this way, I avoid the ugly cast...

Good idea, much nicer than mine! Can you send that patch?

    Arnd
