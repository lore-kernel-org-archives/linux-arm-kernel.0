From: schwab@suse.de (Andreas Schwab)
Date: Tue, 01 Dec 2015 12:01:12 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <2776283.xtmDQm6BqS@wuerfel> (Arnd Bergmann's message of "Tue, 01
 Dec 2015 11:22:02 +0100")
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <20151130202141.GA23254@yury-N73SV> <87bnaafrt0.fsf@igel.home>
 <2776283.xtmDQm6BqS@wuerfel>
Message-ID: <87zixue8lj.fsf@igel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 01 December 2015 10:20:59 Andreas Schwab wrote:
>> Yury Norov <ynorov@caviumnetworks.com> writes:
>> 
>> > There's a tricky bug with signal stack, that Andreas also discovered.
>> 
>> That was only a confusion about the compat state of sys_rt_sigaction.
>> It just requires making sure glibc uses the correct (64bit layout)
>> struct kernel_sigaction.
>
> I don't think we need to use the 64-bit version of sigaction, both
> kernel and libc are simpler if we use the normal 32-bit version.

Since glibc has to do the conversion anyway (due to sigset_t), using the
64bit layout avoids a second conversion in the kernel.

> We should always default to using the generic 32-bit structures
> unless there is a strong reason not to.

The goal should be to avoid conversion layers where it makes sense.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
