From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Mon, 28 Apr 2014 13:45:54 +0530
Subject: [PATCH 1/2 v4] i2c: exynos5: add support for HSI2C on Exynos5260
 SoC
In-Reply-To: <20140312191851.GB28891@katana>
References: <1385100726-32165-1-git-send-email-ch.naveen@samsung.com>
 <1391748171-12451-1-git-send-email-ch.naveen@samsung.com>
 <20140312191851.GB28891@katana>
Message-ID: <CAHfPSqDAUpJWO3Udnjxim-LRY_hjW4+W2j5eTm+Xuk_Np+jhFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On 13 March 2014 00:48, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Feb 07, 2014 at 10:12:51AM +0530, Naveen Krishna Chatradhi wrote:
>> This patch adds a new compatible and uses variant struct to support
>> HSI2C module on Exynos5260. Updates the Documentation dt bindings.
>> Also resets the module as an init sequence (Needed by Exynos5260).
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>
> This patch has clearly not been tested :( Build failure!
comma was missing, Not sure, how i missed it.
Will fix it.
>
>> +struct exynos_hsi2c_variant {
>> +     unsigned int                fifo_depth;
>> +};
>
> Why so many tabs? In general, I'd prefer one space.
>
>> -     exynos5_i2c_init(i2c);
>> +     exynos5_i2c_reset(i2c);
>
> Is this a related change?
Exynos5260 needs the HSI2C module to be reset during the init.
As per Tomasz's comment on earlier version. We will reset the status
during init for every SoC.
>



-- 
Shine bright,
(: Nav :)
