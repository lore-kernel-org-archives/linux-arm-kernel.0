From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 13 Sep 2015 18:32:28 -0700
Subject: Build regressions/improvements in v4.3-rc1
In-Reply-To: <20150913165758.GE21084@n2100.arm.linux.org.uk>
References: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
 <20150913151926.GA19850@roeck-us.net>
 <20150913165758.GE21084@n2100.arm.linux.org.uk>
Message-ID: <55F623AC.4050408@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 09/13/2015 09:57 AM, Russell King - ARM Linux wrote:
> On Sun, Sep 13, 2015 at 08:19:26AM -0700, Guenter Roeck wrote:
>> arm:rpc_defconfig:
>>
>> fs/fat/dir.c: In function 'fat_ioctl_filldir':
>> fs/fat/dir.c:752:43: internal compiler error: Max. number of generated reload insns per insn is achieved (90)
>
> Not much can be done about that - gcc people aren't interested in fixing
> ARMv3 compiler support anymore, although this is still buildable with
> older compilers.  I don't see any point in removing the platform just
> because GCC has decided to break itself.
>
To be fair, they actually fixed a number of similar problems recently,
though I don't know if they happened to fix this one in later versions of gcc.
This specific error seems to be pretty far spread.

Guess you are saying that there is no plan to implement a workaround.
Fair enough; I'll just remove the configuration from my list of tests.

>> arm64:allmodconfig:
>>
>> drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before ?__asmeq?
>> drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function ?secure_flush_area?
>> drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function ?outer_inv_range?
>> drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before ?__asmeq?
>> drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before ?__asmeq?
>
> This file shouldn't be built on ARM64, and there's a fix in the pipeline
> which obviously didn't make -rc1 for it.
>

Fixes are in the pipeline for most of the problems. Only exception is alpha;
the patches necessary to fix the problems there only met silence.

I'll probably wait for -rc4 or -rc5 and then send a pull request for everything
that is left directly to Linus.

Thanks,
Guenter
