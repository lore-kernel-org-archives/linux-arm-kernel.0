From: fkan@apm.com (Feng Kan)
Date: Wed, 16 Jul 2014 10:57:37 -0700
Subject: Kexec on arm64
In-Reply-To: <1405443898.22585.7.camel@smoke>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
Message-ID: <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 10:04 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi,
>
> On Tue, 2014-07-15 at 21:35 +0530, Arun Chandran wrote:
>> So I am assuming some code at 0x238 is waiting for
>> secondary_kernel_start address
>> @000000400000fff8
>>
>> So I modified my dtb file and made 0x238 as 'cpu-return-addr '
>>
> ...
>>
>> Is this correct?
>
> I doubt it.  I recommend you contact whoever you are contracted to do
> this work for and ask them for the value.
>
> As I mentioned in a mail from yesterday, I pushed out a work around for
> this.  Did you try it?
>
> For anyone who comes across this thread and wants to follow it back to
> find that mail I sent out, good luck...

Hi Guys:

Just following up on the conversation. The cpu return address of 0 should work
in your case. Since thats the _start of the bootloader, it will run
some core init
code and then put the core back in wfe. However, I think this
functionality should
be pushed back into the kernel side to provide some small page of spin
code rather
than depend on the bootloader. The address 0 could be OCM or NOR flash, in the
on chip memory case, the space could potentially be used for other means.

>
> -Geoff
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
