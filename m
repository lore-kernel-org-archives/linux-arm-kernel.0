From: schwab@suse.de (Andreas Schwab)
Date: Thu, 12 Nov 2015 00:07:41 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <20577001.4Nl3YnQ8k2@wuerfel> (Arnd Bergmann's message of "Wed,
 11 Nov 2015 21:40:32 +0100")
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <1446507046-24604-14-git-send-email-ynorov@caviumnetworks.com>
 <mvmsi4cxw07.fsf@hawking.suse.de> <20577001.4Nl3YnQ8k2@wuerfel>
Message-ID: <87k2pojfsy.fsf@igel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 11 November 2015 18:54:00 Andreas Schwab wrote:
>> Yury Norov <ynorov@caviumnetworks.com> writes:
>> 
>> > +#define sys_clock_gettime       compat_sys_clock_gettime
>> > +#define sys_clock_settime       compat_sys_clock_settime
>> 
>> You also need to redirect sys_clock_nanosleep.
>
> Note that based on my comment, that table would be turned around, and
> only the syscalls get overridden that do not have the normal
> compat mode behavior (mostly the ones that pass a 64-bit register).

Is it intented that _all_ off_t-like syscalls are implemented by the
64bit variants?  Currently, this isn't fully implemented (lseek is
implemented by sys_llseek and mmap by an mmap2 wrapper).

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
