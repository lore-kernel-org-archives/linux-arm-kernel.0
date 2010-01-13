From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 13 Jan 2010 15:57:12 -0500
Subject: Question: __ARM_EABI__
In-Reply-To: <19278.11469.95923.629825@pilspetsen.it.uu.se>
References: <BD79186B4FD85F4B8E60E381CAEE190902089C63@mi8nycmail19.Mi8.com>
	<19278.11469.95923.629825@pilspetsen.it.uu.se>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089C95@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 13, 2010 1:28 PM, Mikael Pettersson wrote:
> H Hartley Sweeten writes:
>> Hello all,
>> 
>> The following commit added a check for __ARM_EABI__ and raises a
>> warning if it's not defined.
>> 
>> commit 6603a4fd5195a004dec5f9568e38ff76bae630c1
>> Author: Claudio Scordino <claudio@evidence.eu.com>
>> Date:   Fri Oct 30 12:06:05 2009 +0100
>> 
>>     ARM: 5776/1: Check compiler version and EABI support when adding ARM unwind support.
>> 
>> Where is this definition supposed to come from?
>
> The C compiler used to compile the kernel.

OK.  I'm using a gcc-4.3.2 compiler created with crosstool-NG:

 $ ~/toolchain/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-gcc --version
.arm-unknown-linux-gnueabi-gcc (crosstool-NG-hg_default at 1523_6c2a6c04187e) 4.3.2
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

>> I am using an EABI compiler but the warning still shows up.
>
> Then your compiler is broken, or you haven't told it to be EABI.
>
> gcc-4.4 works.

If I compile the following with the toolchain above:

#if defined(__ARM_EABI__)
#warning __ARM_EABI__ is defined
#endif

int main(int argc, char *argv[])
{
	return 0;
}

I get:

$ ~/toolchain/x-tools/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-gcc tmp.c
tmp.c:2:2: warning: #warning __ARM_EABI__ is defined

If I compile the same file with my host gcc (gcc (Debian 4.3.2-1.1) 4.3.2) I don't get
the warning message.

So the option appears to be present in my toolchain but I still get
the warning when compiling the kernel.

Any other ideas?

Regards,
Hartley
