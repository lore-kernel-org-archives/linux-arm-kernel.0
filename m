From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 14 Aug 2011 18:05:55 +0200
Subject: FYI GCC 4.6.x miscompiles the kernel
In-Reply-To: <201108140327.06726.marek.vasut@gmail.com> (Marek Vasut's message
	of "Sun, 14 Aug 2011 03:27:05 +0200")
References: <m3y5ywx602.fsf@intrepid.localdomain>
	<201108140327.06726.marek.vasut@gmail.com>
Message-ID: <m31uwo6krg.fsf_-_@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correction: this bug isn't ARM-specific.

Marek Vasut <marek.vasut@gmail.com> writes:

>> Current gcc-4.6.x SVN, ARMEB EABI.
>
> Shouldn't this go to GCC ML too ?

Nope, I put it in bugzilla.

>> unsigned var[2];
>>
>> void test(int arg)
>> {
>>         unsigned v = *(volatile unsigned *)(&var[arg]);
>>         *(volatile unsigned *)(&var[arg]) = v;
>> }
>>
>> Disassembly of section .text:
>>
>> 00000000 <test>:
>>    0:   e12fff1e        bx      lr

On x86-64:
0000000000000000 <test>:
   0:   f3 c3                   repz retq
-- 
Krzysztof Halasa
