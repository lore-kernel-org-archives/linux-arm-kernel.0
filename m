From: robherring2@gmail.com (Rob Herring)
Date: Tue, 12 Mar 2013 13:53:49 -0500
Subject: [PATCH v2 02/14] clocksource: sp804: add device tree support
In-Reply-To: <201303121851.35326.arnd@arndb.de>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-3-git-send-email-haojian.zhuang@linaro.org>
 <201303121851.35326.arnd@arndb.de>
Message-ID: <513F79BD.1050903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 01:51 PM, Arnd Bergmann wrote:
> On Tuesday 12 March 2013, Haojian Zhuang wrote:
>> +static void __init sp804_dt_init(void)
>> +{
> ...
>> +
>> +       np = of_find_matching_node(from, sp804_timer_match);
> ...
>> +}
>> +CLOCKSOURCE_OF_DECLARE(sp804, "arm,sp804", sp804_dt_init);
> 
> On second thought, I guess it would be nice if we could change the
> calling conventions for CLOCKSOURCE_OF_DECLARE init functions to
> always pass the device along.  It is a bit silly if we already have
> the node in clocksource_of_init and then require the init function
> to call of_find_matching_node(). That change would also make patch
> 3 in this series unnecessary.
> 

My pull request to you yesterday does this. And I also have similar
sp804 patches I'm working on...

Rob
