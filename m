From: therealbadguy@gmail.com (Chris)
Date: Tue, 1 Feb 2011 14:29:54 -0700
Subject: iMX31 MBX registers Porting problem
In-Reply-To: <AANLkTin+gjAzT+PbQx1bm2wxao58oynMGfW4MxXd6K-D@mail.gmail.com>
References: <AANLkTin+Mo9YXEfoDAa+btjX5VdiOz1QJp++ck0efPAk@mail.gmail.com>
	<20110131003128.GD27436@n2100.arm.linux.org.uk>
	<AANLkTi=EsCCwgiK5BtkKfaYEuzVUtnie-LU77cNJ4P4q@mail.gmail.com>
	<20110131154523.GB32737@n2100.arm.linux.org.uk>
	<AANLkTin4fPo6pKWLCqb+BXNS-hDrWPLEK7QQErbuq15C@mail.gmail.com>
	<AANLkTin+gjAzT+PbQx1bm2wxao58oynMGfW4MxXd6K-D@mail.gmail.com>
Message-ID: <AANLkTi=Y4qabbmM+8DRZ3KYZFkk_Chwa5gs80wTH_MSO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 1, 2011 at 2:05 PM, Chris <therealbadguy@gmail.com> wrote:
>> ?I have gone the extra distance in turning off support in the working kernel
>> 2.6.19.2, I have removed nearly everything. I am down to the gpio_port
>>
>

I was finally able to get this device to stop working on 2.6.19.2

it seems that a mapping is being done to the peripheral port register.

/* Setup Peripheral Port Remap register for AVIC */
        asm("ldr r0, =0xC0000015                                \n\
         mcr p15, 0, r0, c15, c2, 4");

once this code is disabled, speaking to my device no longer returns
the expected results.
however, simply pasting this code in the new kernel does not
immediately bring me happiness.
this is from a fixup routine used in kernel 2.6.19.2, so I cloned that
logic and created a fixup routine.
I think perhaps that some other things have gotten in the way.

Are there any changes that would impact me here that anyone knows of?
my concern is now that there is not the only code enabling this
access, and I am trying to research that end of it.
I am pretty confident this is not device specific any more, but more
platform support.

I know noone is working on this device, but perhaps some experience
with this register will help.
I am amazed that all these chips are parked on the new kernel versions,
does anyone have any plans to ever work with this stuff?

I think we need this working. at least bring the support as far
forward as I can.

My Last post: Stupid fingers hit enter, so sorry guys. :(
