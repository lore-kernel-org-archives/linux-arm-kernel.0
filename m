From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Fri, 16 Aug 2013 10:28:23 +0530
Subject: [PATCH v10] i2c: exynos5: add High Speed I2C controller driver
In-Reply-To: <20130815131226.GI17155@katana>
References: <1354021236-28596-2-git-send-email-ch.naveen@samsung.com>
 <1371638905-30633-1-git-send-email-ch.naveen@samsung.com>
 <3925484.kHD24rQYyy@amdc1227> <20130815131226.GI17155@katana>
Message-ID: <CAHfPSqBnj2OTHdbnW3SCRf7SL1maMsWau1+9DWFLYRBM+1HOJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2013 18:42, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Mon, Jul 01, 2013 at 12:25:19PM +0200, Tomasz Figa wrote:
>> Hi Naveen,
>>
>> Looks mostly good, but see some comments inline.
>
> Ping?
Hello Wolfram,

I made a patch fixing your comments and from Thomas Figa as well.

Meanwhile, we hit a random crash in exynos5_i2c_irq function.
The "len" variable being is still being near the FIFO_MAX after this condition
 len = HSI2C_FIFO_MAX - fifo_level;
 +             if (len > i2c->msg->len)
 +                     len = i2c->msg->len;

Once, we fix this problem. i planned to rebase and submit.

Is it okey with you?

Thanks,
Naveen
>



-- 
Shine bright,
(: Nav :)
