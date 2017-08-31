From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 31 Aug 2017 12:01:40 -0500
Subject: [PATCH] scripts/dtc: fix '%zx' warning
In-Reply-To: <20170831161611.GT20805@n2100.armlinux.org.uk>
References: <E1da2Z7-0008GG-AV@rmk-PC.armlinux.org.uk>
 <20170726013004.GJ8978@umbus.fritz.box>
 <20170808112818.GC20805@n2100.armlinux.org.uk>
 <20170809040642.GG13670@umbus.fritz.box>
 <CAL_JsqKiM_T-ftd8NvHmzcRsirRWTe34jZRjZ=3NGSgb4HGncQ@mail.gmail.com>
 <20170831161611.GT20805@n2100.armlinux.org.uk>
Message-ID: <CAL_Jsq+1gMR2MCEXA6UOiK+4NpxT4k71YGqWzW7hZNCWnRg0hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 11:16 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Aug 31, 2017 at 10:58:12AM -0500, Rob Herring wrote:
>> On Tue, Aug 8, 2017 at 11:06 PM, David Gibson
>> <david@gibson.dropbear.id.au> wrote:
>> > On Tue, Aug 08, 2017 at 12:28:19PM +0100, Russell King - ARM Linux wrote:
>> >> On Wed, Jul 26, 2017 at 11:30:04AM +1000, David Gibson wrote:
>> >> > On Tue, Jul 25, 2017 at 05:20:09PM +0100, Russell King wrote:
>> >> > > dtc uses an incorrect format specifier for printing a uint64_t value.
>> >> > > uint64_t may be either 'unsigned long' or 'unsigned long long' depending
>> >> > > on the host architecture.
>> >> > >
>> >> > > Fix this by using %llx and casting to unsigned long long, which ensures
>> >> > > that we always have a wide enough variable to print 64 bits of hex.
>> >> > >
>> >> > >   HOSTCC  scripts/dtc/checks.o
>> >> > > scripts/dtc/checks.c: In function 'check_simple_bus_reg':
>> >> > > scripts/dtc/checks.c:876:2: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'uint64_t' [-Wformat=]
>> >> > >   snprintf(unit_addr, sizeof(unit_addr), "%zx", reg);
>> >> > >   ^
>> >> > > scripts/dtc/checks.c:876:2: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'uint64_t' [-Wformat=]
>> >> > >
>> >> > > Fixes: 828d4cdd012c ("dtc: check.c fix compile error")
>> >> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> >> >
>> >> > This (embarrassing) error is already fixed in upstream dtc.
>> >>
>> >> It remains unfixed in 4.13-rc4.  How do we get this fixed in the
>> >> kernel's dtc?  From what I can see, sending a patch to fix stuff
>> >> doesn't work.
>>
>> Sorry, didn't see this until Andrew M picked it up.
>
> How do we know whether whatever is in upstream dtc fixes the problem
> that I'm seeing?

Build upstream dtc or here's a branch[1] with the cherry-picked fix.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/testing
