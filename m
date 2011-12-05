From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 5 Dec 2011 16:17:16 +0530
Subject: [PATCH 2/2] arm: exynos: allow platform-lcd driver to control lcd
 regulator source on origen
In-Reply-To: <CAH9JG2XfNqCtxhfqiikuZKbvZnc2tZ2vGJ0FZuL=JcQirYJXTA@mail.gmail.com>
References: <1323075148-29356-1-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2XfNqCtxhfqiikuZKbvZnc2tZ2vGJ0FZuL=JcQirYJXTA@mail.gmail.com>
Message-ID: <CAJuYYwRD9iop3k1ApcELgpk1R2rw0PX-nVLcstj35cVq9VKy7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Park,

On 5 December 2011 15:44, Kyungmin Park <kmpark@infradead.org> wrote:

[...]

>> ?static struct regulator_init_data __initdata max8997_ldo1_data = {
>> @@ -379,11 +379,11 @@ static struct regulator_init_data __initdata
>> max8997_buck5_data = {
>> ?static struct regulator_init_data __initdata max8997_buck7_data = {
>> ? ? ? .constraints ? ?= {
>> ? ? ? ? ? ? ? .name ? ? ? ? ? = "VDD_LCD_3.3V",
>> - ? ? ? ? ? ? .min_uV ? ? ? ? = 3300000,
>> - ? ? ? ? ? ? .max_uV ? ? ? ? = 3300000,
>> + ? ? ? ? ? ? .min_uV ? ? ? ? = 750000,
>> + ? ? ? ? ? ? .max_uV ? ? ? ? = 3900000,
> It can support the voltage change at buck itself, but in board it's
> fixed. I'm not sure it's correct usage at board file.
>
> I think original code is better to understand and use it as name, it's
> fixed v3.3 voltage.

Yes, that is true. If the board cannot support any other voltage for
buck7, there is no need to change min_uV and max_uV. I will revert it
to the original values.

Thanks,
Thomas.

>
> Thank you,
> Kyungmin Park

[...]
