From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 2 May 2015 10:37:09 +0200
Subject: [RFC PATCH] ARM: add fixmap based earlycon support
In-Reply-To: <20150501161812.GN12732@n2100.arm.linux.org.uk>
References: <1430315508-7582-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150501161812.GN12732@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu-8ixKQtkpf=umHB76OZxo-dfGkOiQqDO7=evMebyDdUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 May 2015 at 18:18, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Apr 29, 2015 at 03:51:48PM +0200, Ard Biesheuvel wrote:
>> This adds support for fixmap based earlycon by moving the fixmap
>> initialization to an earlier stage and introducing the Kconfig symbol
>> that wires up the existing code.
>
> I don't see the patches for this fixmap based earlycon.  What's the
> status of those, and how are they getting into mainline?
>

They are already /in/ mainline. This single patch is all that is
required to wire it up for ARM.

However, I did notice after sending this that another implementation
had been proposed already:
http://lkml.iu.edu/hypermail/linux/kernel/1412.3/00855.html

I am not sure which one is more correct, but the general idea is the
same, i.e., to allocate the fixmap PTEs from bss rather than the heap.
