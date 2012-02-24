From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 24 Feb 2012 09:44:14 +0530
Subject: [PATCH v2 0/7] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
In-Reply-To: <20120223185217.GY18185@atomide.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
 <20120223185217.GY18185@atomide.com>
Message-ID: <4F470E96.50200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 February 2012 12:22 AM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [120223 03:09]:
>> Re-sending as these patches did not make it to the lists due to
>> issues with my 'git send-email'
>>
>> Hi Tony,
>>
>> This is a re-spin of your series to fix up the section
>> mismatch warnings noted by Russell with omap2_hsmmc_init().
>> The previous series had an issue around multiple insmod/rmmod
>> of the twl4030 gpio driver when built as a module as reported
>> by Russell again.
>
> OK, can you please rebase your patches on hsmmc branch in linux-omap
> at commit 0e91c8ddf0e0932da59ec1d116e34049791b0e73?

Ok, will do.

>
> Note that at least the hardcoded GPIO numbers are no longer needed.

Ok, I explained my rational in the other mail thread. Its always been
hardcoded GPIO numbers and this will change only with DT as Benoit
mentioned. I was just trying to make the hard-coding more readable.
Will remove it and do it how it was done earlier, which is populate
it in the callback.

>
>> There were 2 issues, one with gpio_requests failing as they were
>> never freed on the module unload/unbind. The other was with the
>> mmc devices being registered again. I have fixed both these issues
>> in this series, mainly by having a .teardown hook for twl4030 gpio
>> driver populated from all OMAP3 board files, which release all the
>> requested gpios and also unregister the mmc omap/platform device.
>
> Yes that's great.
>
> Regards,
>
> Tony
