From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 21 May 2014 16:53:05 +0530
Subject: [PATCH] i2c: exynos5: add support for HSI2C on Exynos5260 SoC
In-Reply-To: <20140521103432.GM2708@katana>
References: <1398675598-25991-1-git-send-email-ch.naveen@samsung.com>
 <20140521103432.GM2708@katana>
Message-ID: <CAHfPSqDwg9z27jPHaZohYCvr314dye1Wd6dgYQKP7Ub7=gSVuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On 21 May 2014 16:04, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Apr 28, 2014 at 02:29:58PM +0530, Naveen Krishna Chatradhi wrote:
>> HSI2C module on Exynos5260 differs from current modules in
>> following ways:
>> 1.  HSI2C on Exynos5260 has fifo_depth of 16bytes
>> 2.  Module needs to be reset as a part of init sequence.
>>
>> Hence, Following changes are involved.
>> 1. Add a new compatible string and Updates the Documentation dt bindings.
>> 2. Introduce a variant struct to support the changes in H/W
>> 3. Reset the module during init. Thus, bringing the module back
>> to default state irrespective of what firmware did with it.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ich.naveen@samsung.com>
I just realized another typo. Its my email id:  ch.naveen at samsung.com

>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>
> ...
>
>> -             fifo_ctl |= HSI2C_RXFIFO_TRIGGER_LEVEL(HSI2C_DEF_TXFIFO_LVL);
>> +             trig_lvl = (i2c->msg->len > i2c->variant->fifo_depth) ?
>> +                     (i2c->variant->fifo_depth * 3/4) : i2c->msg->len;
>> +             fifo_ctl |= HSI2C_RXFIFO_TRIGGER_LEVEL(trig_lvl);
>> +
>
> Dunno why checkpatch missed the 'space around operator' issue, yet I
> fixed it here...
>
> Applied to for-next, thanks!
You want me to send another version fixing these nits ?
>



-- 
Shine bright,
(: Nav :)
