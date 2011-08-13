From: lacombar@gmail.com (Arnaud Lacombe)
Date: Sat, 13 Aug 2011 12:02:32 -0400
Subject: [PATCH] ARM: zImage: Skip relinking if nothing changes
In-Reply-To: <20110813063409.GA29111@merkur.ravnborg.org>
References: <4E457682.5020107@codeaurora.org>
	<1313175602-21834-1-git-send-email-sboyd@codeaurora.org>
	<CACqU3MUq5M-XPOxV=8GKyEzjEzpmdeaF+mGrXJrK+ZZxa4SdeQ@mail.gmail.com>
	<20110812205520.GL4775@n2100.arm.linux.org.uk>
	<CACqU3MX=-10ouxCqWcBP7MW3_O4_RSLG9wRY8X4iEh5ydQa1AQ@mail.gmail.com>
	<20110812220316.GA28845@merkur.ravnborg.org>
	<CACqU3MUVir_hfAtVz24Y7NrQOHAa=WyyHnCN4M6BHLQ294Tdww@mail.gmail.com>
	<20110813063409.GA29111@merkur.ravnborg.org>
Message-ID: <CACqU3MVHgF276SmQFWMcMRL470wz5F4=t0ZmKQ3YoK6Gy9=ETA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Aug 13, 2011 at 2:34 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Aug 12, 2011 at 06:17:25PM -0400, Arnaud Lacombe wrote:
>> Hi,
>>
>> On Fri, Aug 12, 2011 at 6:03 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> >>
>> >> I suspect this would have done the job:
>> >>
>> >> $(obj)/font.o: $(srctree)/drivers/video/console/font_acorn_8x8.c
>> >> ? ? ? ? $(cmd,cc_o_c)'
>> >
>> > I prefer using $(call,shipped) and let kbuild figure out how
>> > build an .o file from a .c file.
>> >
>> > In other words - avoiding use of the internal to Makefile.build
>> > variables in various places.
>> >
>> indeed, but I'd argue that 1) this would not be the first Makefile
>> using these internal macros (alpha and ia64 are using such construct
>> for aliasing) and 2) the `cmd_shipped' stuff is as internal than other
>> functions :-)
> A quick grep in Documentation/kbuild will show that only the shipped
> variant is documented.
>
> We could implement a general copy command - this is needed in some places
> like this.
>
I was more thinking of a way to use a single source file, for multiple
target, built in different location, without having to make useless
copy or cross-subdirectory target dependencies, and removing all
non-internal use of cc_c_o, and friends.

 - Arnaud
