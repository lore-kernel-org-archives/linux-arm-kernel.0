From: schwab@suse.de (Andreas Schwab)
Date: Wed, 11 Mar 2015 14:57:02 +0100
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <2583329.jVX0TanYzO@wuerfel> (Arnd Bergmann's message of "Wed, 11
 Mar 2015 14:51:28 +0100")
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
 <C0CF99B1-8706-4D9B-87E0-13A7C6C619D6@suse.de>
 <mvmegovejx0.fsf@hawking.suse.de> <2583329.jVX0TanYzO@wuerfel>
Message-ID: <mvma8zjeixd.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 11 March 2015 14:35:39 Andreas Schwab wrote:
>> +#if PAGE_SIZE > 12
>> +asmlinkage long compat_sys_mmap2_wrapper(void);
>> +#else
>> +#define compat_sys_mmap2_wrapper sys_mmap_pgoff
>> +#endif
>> 
>
> PAGE_SIZE is always larger than 12 ;-)

s/PAGE_SIZE/PAGE_SHIFT/

Thanks, Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
