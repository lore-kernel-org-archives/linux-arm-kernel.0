From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 05 Jun 2017 10:35:37 +0100
Subject: arm64: segfaults on next-20170602 with LTP tests
In-Reply-To: <20170602152440.GQ6371@arm.com> (Will Deacon's message of "Fri, 2
 Jun 2017 16:24:41 +0100")
References: <20170602111151.r2x3364zqabmshzo@yury-thinkpad>
 <20170602121917.GG6371@arm.com>
 <20170602123751.3jzdkjwntbce2e6e@yury-thinkpad>
 <20170602144204.uyvbby5vauxpt6yr@yury-thinkpad>
 <20170602152440.GQ6371@arm.com>
Message-ID: <87k24q4w0m.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> On Fri, Jun 02, 2017 at 05:42:04PM +0300, Yury Norov wrote:
>> On Fri, Jun 02, 2017 at 03:37:51PM +0300, Yury Norov wrote:
>> > On Fri, Jun 02, 2017 at 01:19:18PM +0100, Will Deacon wrote:
>> > > Hi Yury,
>> > > 
>> > > [adding Steve and Punit]
>> > > 
>> > > On Fri, Jun 02, 2017 at 02:11:51PM +0300, Yury Norov wrote:
>> > > > I see that latest and yesterday's linux-next segfaults with tests pth_str01,
>> > > > pth_str03, rwtest04. Rwtest04 hangs sometimes. Crashes are not always
>> > > > reproducible. About week ago everything was fine. Kernel log and config file
>> > > > are attached. The testing is performed on qemu.
>> > > 
>> > > It's weird that these haven't cropped up in our nightly tests, especially
>> > > given that defconfig is very similar to the one you're using. That said,
>> > > I see huge pmds cropping up in the traces below and there have been some
>> > > recent changes from Punit and Steve in that area, in particular things
>> > > like 55f379263bcc ("mm, gup: ensure real head page is ref-counted when using
>> > > hugepages").
>> > > 
>> > > Are you in a position to bisect this, or is it too fiddly to reproduce?
>> 
>> I have bisected the bug to exactly this patch. If I revert it, the
>> pth_str01/03 are passed.
>
> Thanks for doing that: I had my suspicion ;) I can also reproduce the
> failure locally on my Juno.
>
> Punit -- please can you investigate this? Otherwise I think we have to
> revert this for now and bring it back after some better testing.

Apologies for the breakage. It looks like anonymous hugepages are not
happy with the change. Let me dig into this.

>
> Will
