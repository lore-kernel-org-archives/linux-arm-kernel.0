From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon, 07 Jun 2010 10:08:16 +0100
Subject: [RFC PATCH] stargate2 and imote2 board file merge
In-Reply-To: <20100607070724.GB2702@excalibur.local>
References: <1275832502-28552-1-git-send-email-jic23@cam.ac.uk>
	<20100607070724.GB2702@excalibur.local>
Message-ID: <4C0CB700.8080300@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/10 08:07, Stefan Schmidt wrote:
> Hello.
> 
> On Sun, 2010-06-06 at 14:55, Jonathan Cameron wrote:
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  These two boards are extremely similar in many ways and hence
>>  the board configs overlap a lot.  This patch merges the two
>>  board files.  Do people think this is worth doing?  Traditionally
>>  we always built a kernel supporting both devices anyway but the
>>  ifdefs allow one to be picked if people really want to.
> 
> I find it an interesting idea. We have done this on EZX with 6 devices. One
> thing that jumps into my face is that we should provide a way to let people know
> that the stargate2.c file does indeed also provide support for imote2. At least
> updated comments in KConfig and the header of the c file would be needed. That
> would allow people to discover it during configuration or greping.
Not sure we care particularly in the kconfig as it doesn't make any difference
to someone configuring. Either way they just select the platforms they want.
As for the c, greping will still work, it'll just get the machine definition
rather than the comments at the top.  Still I agree a few comments wouldn't hurt!
> 
> I don't know much about the Crossbow product palette but maybe we should even
> rename it to crossbow.c
Sadly not.  The devices were both originally Intel Research.  They sold the imote2
to crossbow. I think they gave the stargate2 designs to UCLA but I haven't seen any
sign of them doing anything with them and no one has posted anything to the platformx
users list for a while.  To complicate things further the imote2 is now owned by Memsic
after they bought the relevant bit of Crossbow. No idea what their plans are.

I'm inclined just to pick one or the other.  Perhaps we go with imote2
as I suspect there are a lot more them out there! Can't even use platformx
(Intel's code word for these sorts of devices) as that covered the original stargate.
> 
>>  arch/arm/mach-pxa/Makefile    |    2 +-
>>  arch/arm/mach-pxa/imote2.c    |  590 -----------------------------------
>>  arch/arm/mach-pxa/stargate2.c |  679 +++++++++++++++++++++++++++--------------
>>  3 files changed, 454 insertions(+), 817 deletions(-)
> 
> Given that we can eliminate nearly 400 lines of code and one board file I think
> it is worth it. I looked over the patch and it does look good so far. Will give
> it a runtime test the next days. If that truns out well I'm fine to ack it.
:) I'll admit I haven't tested it myself yet.  Didn't have the debug board to hand
to be able to flash it to an imote2 and my sg2's were all in use testing the radio
driver (that is dependent on mac802154 mainlining).  One day we will have these devices
fully supported in mainline.

Jonathan
