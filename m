From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 29 Jun 2017 13:17:37 +0200
Subject: [PATCH 1/5] clk: mb86s7x: Suppress build
In-Reply-To: <20170628222929.GC5316@codeaurora.org>
References: <20170625170020.11791-1-afaerber@suse.de>
 <20170625170020.11791-2-afaerber@suse.de>
 <20170628161354.GB5316@codeaurora.org>
 <CAJe_ZhdkfK1wB88hrMP=kmMNBfqxGtHDxseuyUXHToq77bzQ+g@mail.gmail.com>
 <20170628222929.GC5316@codeaurora.org>
Message-ID: <90983570-ba4d-d58e-b136-de0a1fa1d0c2@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.06.2017 um 00:29 schrieb Stephen Boyd:
> On 06/28, Jassi Brar wrote:
>> On 28 June 2017 at 21:43, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>> On 06/25, Andreas F?rber wrote:
>>>> It fails to build once we introduce the ARCH_MB86S7X Kconfig symbol:
>>>>
>>>>   drivers/clk/clk-mb86s7x.c:27:10: fatal error: soc/mb86s7x/scb_mhu.h: No such file or directory
>>>>    #include <soc/mb86s7x/scb_mhu.h>
>>>>             ^~~~~~~~~~~~~~~~~~~~~~~
>>>>   compilation terminated.
[...]
>>>> Comment it out in the Makefile for now.
>>>>
>>>
>>> Why not delete the whole driver instead? It's been two years and
>>> the driver has never compiled.
>>>
>> I won't complain. The interest of moving powers evaporated in the
>> midst of upstreaming. Though some next platform is supposed to reuse
>> the IPs, but I can't say when will that be upstreamed and by whom.

Satoru-san is in CC to comment on that aspect. :)

> Thanks for the info.
> 
> Andreas, can you send a deletion patch instead?

I can.

But obviously the idea is to follow-up on this initial series with an
scb mailbox driver (which is blocking both clk and PM domains drivers)
and to either resolve the compilation failure by adding the expected
symbols or to update the clk driver to build against a new driver.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
