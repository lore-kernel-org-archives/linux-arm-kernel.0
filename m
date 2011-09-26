From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 26 Sep 2011 09:48:19 -0600
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110926152634.GN2946@opensource.wolfsonmicro.com>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110926141643.GK2946@opensource.wolfsonmicro.com>
	<20110926151210.GO22455@n2100.arm.linux.org.uk>
	<20110926152634.GN2946@opensource.wolfsonmicro.com>
Message-ID: <CACxGe6swdnhk_GCAv3siSx4kxNQXmCLDbwBFjsX5VPNfCBc2Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 9:26 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Sep 26, 2011 at 04:12:10PM +0100, Russell King - ARM Linux wrote:
>> On Mon, Sep 26, 2011 at 03:16:43PM +0100, Mark Brown wrote:
>
>> > used but it's not a blocker for anything. ?Devices doing this would need
>> > some way to figure out if they should -EBUSY or fail otherwise.
>
>> Just to avoid confusion - ITYM -EAGAIN there. ?-EBUSY is already used
>> by drivers to mean "someone else claimed a resource I need" be it the
>> IO region or an IRQ resource...
>
> Yes, I do - sorry.

Actually, in the next iteration, I'm thinking it would be a good idea
to create a new #define to only be used by probe deferral.  I want it
to be easy to find all the drivers that are using this mechanism
without needing to filter all the unrelated hits.  However, this is a
kernel-only thing so it is probably not appropriate to add it to
include/asm-generic/errno.h.  I could use some guidance/advice as to
the best way to handle this.

g.
