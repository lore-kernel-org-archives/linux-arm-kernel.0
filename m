From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 4 Jun 2013 09:24:48 +0800
Subject: [PATCH v3 10/11] ARM: mmp: avoid to use cpu_is_xxx in timer
In-Reply-To: <201306040034.47041.arnd@arndb.de>
References: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
 <1370251845-31373-11-git-send-email-haojian.zhuang@gmail.com>
 <201306040034.47041.arnd@arndb.de>
Message-ID: <CAN1soZzWGzBX55Uf5XRVFSsSR8Pm6CNTt4cyQDVfYXu+o2Ko3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 4, 2013 at 6:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 03 June 2013, Haojian Zhuang wrote:
>>  void __init mmp_dt_init_timer(void)
>>  {
>>         struct device_node *np;
>> +       struct clk *clk;
>>         int irq, ret;
>> +       u32 rate = 0;
>>
>>         np = of_find_matching_node(NULL, mmp_timer_dt_ids);
>> -       if (!np) {
>> -               ret = -ENODEV;
>> -               goto out;
>
> Please use CLOCKSOURCE_OF_DECLARE() here and call clocksource_of_init()
> in the platform code, rather than calling mmp_dt_init_timer directly.
>
>         Arnd

CLOCKSOURCE_OF_DECLARE() is in the 11th patch. And mmp_dt_init_timer()
won't be called in 11th patch.

I split it into 10th & 11th. Since I just want 10th patch to remove
cpu_is_xxx().

Regards
Haojian
