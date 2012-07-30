From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Jul 2012 15:40:37 -0700
Subject: [PATCH] ARM: Sort exception table at compile time
In-Reply-To: <20120730221911.GB10335@n2100.arm.linux.org.uk>
References: <1343683803-15507-1-git-send-email-sboyd@codeaurora.org>
 <20120730215118.GA32670@merkur.ravnborg.org>
 <20120730221911.GB10335@n2100.arm.linux.org.uk>
Message-ID: <50170D65.4080205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/12 15:19, Russell King - ARM Linux wrote:
> On Mon, Jul 30, 2012 at 11:51:18PM +0200, Sam Ravnborg wrote:
>> Here you should be able to use the macro EXCEPTION_TABLE from
>> vmlinux.lds.h.
>> I cannot see why the ifdef for not NON-MMU case is needed,
>> but if it is needed the macro is not good...
> Because you can not mention the same input section in two different
> places and end up with predictable output from the linker.
>
> We discard the __ex_table for noMMU, but I think the start/stop
> symbols are still referenced somewhere.  Dunno, I don't have much to
> do with noMMU ARM, and the only platform I'd be interested in never
> got merged.

I was thinking, perhaps we can ifdef out the exception fixup sections in
the places where they're added? Then we can just use the EXCEPTION_TABLE
macro from vmlinux.lds.h knowing that there are no __ex_table sections
in the input object files?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
