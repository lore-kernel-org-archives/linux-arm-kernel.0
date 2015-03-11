From: agraf@suse.de (Alexander Graf)
Date: Wed, 11 Mar 2015 10:44:22 -0500
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <mvma8zjeixd.fsf@hawking.suse.de>
References: <1417707993-82290-1-git-send-email-agraf@suse.de>	<C0CF99B1-8706-4D9B-87E0-13A7C6C619D6@suse.de>	<mvmegovejx0.fsf@hawking.suse.de>
 <2583329.jVX0TanYzO@wuerfel> <mvma8zjeixd.fsf@hawking.suse.de>
Message-ID: <550062D6.3000101@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11.03.15 08:57, Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
>> On Wednesday 11 March 2015 14:35:39 Andreas Schwab wrote:
>>> +#if PAGE_SIZE > 12
>>> +asmlinkage long compat_sys_mmap2_wrapper(void);
>>> +#else
>>> +#define compat_sys_mmap2_wrapper sys_mmap_pgoff
>>> +#endif
>>>
>>
>> PAGE_SIZE is always larger than 12 ;-)
> 
> s/PAGE_SIZE/PAGE_SHIFT/

Yup, that patch does make things work too. With the replacement above

Tested-by: Alexander Graf <agraf@suse.de>

Andreas, would you like to send this upstream as a proper top-level
patch or would you prefer if I do a patch set with the 2 patches (enable
CONFIG_COMPAT on 64k PAGE_SIZE and your patch)?


Alex
