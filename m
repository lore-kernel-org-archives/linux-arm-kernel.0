From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Oct 2013 09:48:41 -0700
Subject: Use of drivers/platform and matching include?
In-Reply-To: <20131004132209.GB23923@kroah.com>
References: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
 <CAOesGMjJ6Uj0uGFJqtnWQyDW+tr6eLVWoHZ+B7uFna+L8N6E8Q@mail.gmail.com>
 <20131004114128.GL12758@n2100.arm.linux.org.uk>
 <20131004132209.GB23923@kroah.com>
Message-ID: <CAOesGMjxwmr0Vo0Puc-nZntgXLy6D1PTohz=C+fFukP_Eu1iQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 4, 2013 at 6:22 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Oct 04, 2013 at 12:41:28PM +0100, Russell King - ARM Linux wrote:
>>
>> So, no, there will be no new drivers under arch/arm.  They must be in the
>> drivers subtree somewhere.
>
> I have no objection with this, and encourage it.

Ok, so these are some of the requirements as far as I see it:

* No per-vendor driver dumping ground under drivers/* (i.e. no
drivers/platform/<soc vendor>/)
* No weirdly constructed single-driver directories directly under
drivers/* (we already have a few and should look at moving those)
because nothing else fits
* We need some sort of convention on dependencies. Several of these
are more libraries than drivers, i.e. we'll have cross-calls for
things like queue management, resource allocation, etc. So having a
single location to hold most of these makes sense instead of
everything cross-depending on everything else.

Based on the above, how about we create something like
drivers/resourcemgr to hold these?   I think at least parts of the
mvebu-mbus driver that ended up under drivers/bus might be a fit to
move there. The APM queue allocator would likely be a fit, and maybe
some of the qualcomm stuff. Kumar, what are your thoughts on that?
Greg?


-Olof
