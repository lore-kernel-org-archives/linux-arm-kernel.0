From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 3 Oct 2011 22:18:34 +0800
Subject: [PATCH v4] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <20111003134145.GE11710@n2100.arm.linux.org.uk>
References: <1317375773-7229-1-git-send-email-Barry.Song@csr.com>
	<20111001150646.GB11710@n2100.arm.linux.org.uk>
	<20111003105658.GC14761@e102568-lin.cambridge.arm.com>
	<20111003134145.GE11710@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4wUD8SdrY3JXqrpRsE1-WK401PxHcSWO8CN06jWdFLodQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/3 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Oct 03, 2011 at 11:57:03AM +0100, Lorenzo Pieralisi wrote:
>> On Sat, Oct 01, 2011 at 04:06:46PM +0100, Russell King - ARM Linux wrote:
>> > On Fri, Sep 30, 2011 at 02:42:53AM -0700, Barry Song wrote:
>> > > From: Barry Song <Baohua.Song@csr.com>
>> > >
>> > > we save the l2x0 registers at the first initialization, and platform codes
>> > > can get them to restore l2x0 status after wakeup.
>> > >
>> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> > > Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> > > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > > Tested-by: Shawn Guo <shawn.guo@linaro.org>
>> >
>> > This looks fine, thanks Barry.
>> >
>> > The one remaining issue is whether we use this or use Lorenzo's patches.
>> > I feel that Barry's version is a lot simpler and easier to use, so this
>> > is my preference. ?Anyone else got another opinion between the two?
>> >
>>
>> Basically the two patches do the same thing except that Barry's generic
>> resume code cannot be called before the MMU is turned on. On the other hand
>> Barry's patch is certainly simpler to maintain and I think it should be
>> merged, preference shared; I would not say it is easier to use though, usage
>> is identical.
>>
>> It is agreed, better to have it in C than in asm for maintenance reasons,
>> asm can turn out overkill.
>> If there is a compelling case for generic L2 asm we can always add it at a
>> later stage (at least Origen, latest iMX and I think Tegra will need early L2
>> resume from idle).
>
> Ok, so it sounds like we're settled on Barry's code... so can it head to
> the patch system please?

done. http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7114/1

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
