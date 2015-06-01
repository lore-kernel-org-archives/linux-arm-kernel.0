From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 1 Jun 2015 10:26:55 +0200
Subject: [RFC PATCH] ARM: add fixmap based earlycon support
In-Reply-To: <CAKv+Gu-8ixKQtkpf=umHB76OZxo-dfGkOiQqDO7=evMebyDdUA@mail.gmail.com>
References: <1430315508-7582-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150501161812.GN12732@n2100.arm.linux.org.uk>
 <CAKv+Gu-8ixKQtkpf=umHB76OZxo-dfGkOiQqDO7=evMebyDdUA@mail.gmail.com>
Message-ID: <CAKv+Gu80bSqXbK5g9g9wBbG33mgqbrxJA68kNgAuK=LOoGDh5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(thread is here: http://thread.gmane.org/gmane.linux.ports.arm.kernel/409329)

On 2 May 2015 at 10:37, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 1 May 2015 at 18:18, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> On Wed, Apr 29, 2015 at 03:51:48PM +0200, Ard Biesheuvel wrote:
>>> This adds support for fixmap based earlycon by moving the fixmap
>>> initialization to an earlier stage and introducing the Kconfig symbol
>>> that wires up the existing code.
>>
>> I don't see the patches for this fixmap based earlycon.  What's the
>> status of those, and how are they getting into mainline?
>>
>
> They are already /in/ mainline. This single patch is all that is
> required to wire it up for ARM.
>
> However, I did notice after sending this that another implementation
> had been proposed already:
> http://lkml.iu.edu/hypermail/linux/kernel/1412.3/00855.html
>
> I am not sure which one is more correct, but the general idea is the
> same, i.e., to allocate the fixmap PTEs from bss rather than the heap.

Anyone else care to comment on this?

DT based earlycon is a *really* useful thing to have if you are
working on early kernel code.
With many of the DTs now having been extended with a
/chosen/stdout-path property, it really only takes a simple 'earlycon'
command line parameter (without any arguments) to get console output
as soon as the early DT scan is concluded. I suppose this is also a
useful thing for multi platform kernels?

BTW the patch still applies to v4.1-rc6

Regards,
Ard.
