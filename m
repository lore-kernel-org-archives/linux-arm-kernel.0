From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 9 Dec 2011 10:47:03 +0530
Subject: [PATCH 2/2] regulator: add device tree support for max8997
In-Reply-To: <CAH9JG2WhH27O6VLZWro_cZ9-TgV+=kjvOM6UiAY=-4eAO1sChA@mail.gmail.com>
References: <1323361659-11835-1-git-send-email-thomas.abraham@linaro.org>
 <1323361659-11835-2-git-send-email-thomas.abraham@linaro.org>
 <1323361659-11835-3-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2WhH27O6VLZWro_cZ9-TgV+=kjvOM6UiAY=-4eAO1sChA@mail.gmail.com>
Message-ID: <CAJuYYwT5xrtxL8eajYDqb8dYWKDpe6RG7_BSk-ku9ecP+dfFvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Park,

On 9 December 2011 08:00, Kyungmin Park <kyungmin.park@samsung.com> wrote:
> On 12/9/11, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> Add device tree based discovery support for max8997.
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

[...]

>> +#else
>> +static int *max8997_i2c_parse_dt_pdata(struct device *dev
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct max8997_platform_data **pdata)
> It should be 'int' instead of 'int *'
>
> It's helpful to compile without CONFIG_OF.

I apologize for that. I compiled for exynos-dt first and then compiled
for origen board (which does not select CONFIG_OF). When compiling for
non-dt origen, I missed to notice that CONFIG_OF selection was left
over from the previous exynos-dt compile.

I have checked again without CONFIG_OF and found this issue as well as
two other errors/warnings.

Thanks. This was very helpful.

Regards,
Thomas.

[...]
