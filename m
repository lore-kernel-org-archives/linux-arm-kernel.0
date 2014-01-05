From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Mon, 06 Jan 2014 00:30:37 +0100
Subject: [PATCH v4 1/4] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <201401052030.07765.arnd@arndb.de>
References: <1388944697-19927-1-git-send-email-hauke@hauke-m.de>
 <1388944697-19927-2-git-send-email-hauke@hauke-m.de>
 <201401052030.07765.arnd@arndb.de>
Message-ID: <52C9EB1D.802@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2014 08:30 PM, Arnd Bergmann wrote:
> On Sunday 05 January 2014, Hauke Mehrtens wrote:
>> +static void __init bcm5301x_timer_init(void)
>> +{
>> +       of_clk_init(NULL);
>> +       clocksource_of_init();
>> +}
>> +
>> +static void __init bcm5301x_dt_init(void)
>> +{
>> +       l2x0_of_init(0, ~0UL);
>> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> +}
> 
> I'm pretty sure the first of these two functions is no longer needed,
> and there were at least plans to make the second one optional as well.
> 
> Can you remove bcm5301x_timer_init() now?

Yes I will remove bcm5301x_timer_init(), but calling l2x0_of_init() is
still needed with kernel 3.13-rc7.

Hauke
