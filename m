From: stefan@agner.ch (Stefan Agner)
Date: Mon, 01 Jun 2015 13:00:49 +0200
Subject: [RFC PATCH] ARM: add fixmap based earlycon support
In-Reply-To: <CAKv+Gu80bSqXbK5g9g9wBbG33mgqbrxJA68kNgAuK=LOoGDh5w@mail.gmail.com>
References: <1430315508-7582-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150501161812.GN12732@n2100.arm.linux.org.uk>
 <CAKv+Gu-8ixKQtkpf=umHB76OZxo-dfGkOiQqDO7=evMebyDdUA@mail.gmail.com>
 <CAKv+Gu80bSqXbK5g9g9wBbG33mgqbrxJA68kNgAuK=LOoGDh5w@mail.gmail.com>
Message-ID: <231c68169cd389d5658b29553d555945@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-01 10:26, Ard Biesheuvel wrote:
> (thread is here: http://thread.gmane.org/gmane.linux.ports.arm.kernel/409329)
> 
> On 2 May 2015 at 10:37, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
<snip>
>> However, I did notice after sending this that another implementation
>> had been proposed already:
>> http://lkml.iu.edu/hypermail/linux/kernel/1412.3/00855.html
>>
>> I am not sure which one is more correct, but the general idea is the
>> same, i.e., to allocate the fixmap PTEs from bss rather than the heap.
> 
> Anyone else care to comment on this?
> 
> DT based earlycon is a *really* useful thing to have if you are
> working on early kernel code.
> With many of the DTs now having been extended with a
> /chosen/stdout-path property, it really only takes a simple 'earlycon'
> command line parameter (without any arguments) to get console output
> as soon as the early DT scan is concluded. I suppose this is also a
> useful thing for multi platform kernels?
> 
> BTW the patch still applies to v4.1-rc6

I would appreciate earlycon support too. Serial stuff happen to be
initialized rather late on the HW I work often with, hence I quite often
have to enable/disable earlyprintk at the moment.

The patch I sent is missing a tlb flush, I can send a v2 if that
approach is preferred. On the other hand, your approach seems to be
simpler, judging from the number of changed lines...

--
Stefan
