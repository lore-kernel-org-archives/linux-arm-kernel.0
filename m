From: pinskia@gmail.com (Andrew Pinski)
Date: Fri, 13 Nov 2015 07:38:49 -0800
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <3810107.ZiMyX4Iloo@wuerfel>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <16446627.b0Lo936ZJj@wuerfel> <mvm4mgrxrbt.fsf@hawking.suse.de>
 <3810107.ZiMyX4Iloo@wuerfel>
Message-ID: <CA+=Sn1mQ+1HRS_=X-RN92yRXD6Xt6xk-ATiX+u=c3_KYsWgtKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 7:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 12 November 2015 14:47:18 Andreas Schwab wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>> > On Thursday 12 November 2015 10:44:55 Andreas Schwab wrote:
>> >> Arnd Bergmann <arnd@arndb.de> writes:
>> >>
>> >> > What do you mean with 32-bit off_t?
>> >>
>> >> An ABI with 32-bit off_t, ie. all currently implemented 32-bit ABIs.
>> >>
>> >> > Do you mean that glibc emulates a 32-bit off_t on top of the 64-bit
>> >> > __kernel_loff_t?
>> >>
>> >> Glibc is bridging the user-space ABI to the kernel ABI.
>> >
>> > Ok, but why?
>>
>> That's how the ABI is defined right now.  I didn't make that up.
>
> Ok, I guess it will remain a mystery then.

The biggest question is here is how much compatibility do we want with
other 32bit ABIs?
Do we want off_t to be 32bit or 64bit?

>
> Should we perhaps define __ARCH_WANT_SYSCALL_OFF_T for the unistd.h
> file then, so we provide both the off_t and the loff_t based syscalls?

I think that is backwards ...

>
> That would avoid the extra wrapper in glibc when using a 32-bit
> off_t if that is the preferred mode for user space.


Other targets like tilegx does not do that and has a pure 32bit mode.
Only score does that.

Thanks,
Andrew

>
>         Arnd
