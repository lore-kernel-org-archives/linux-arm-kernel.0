From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 5 Jun 2013 20:33:51 +0300
Subject: [PATCH] dmatest: do not allow to interrupt ongoing tests
In-Reply-To: <Pine.LNX.4.64.1306051924190.19739@axis700.grange>
References: <1369308593-3723-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <Pine.LNX.4.64.1305242353210.7187@axis700.grange>
 <1369638667.29283.197.camel@smile>
 <20130605171001.GC26663@mudshark.cambridge.arm.com>
 <Pine.LNX.4.64.1306051924190.19739@axis700.grange>
Message-ID: <CAHp75Vdv=ybs7jJ1k6rfPoxAyEmhtMr8CSaSrdU+1dMDSr5x+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 5, 2013 at 8:25 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Wed, 5 Jun 2013, Will Deacon wrote:
>> On Mon, May 27, 2013 at 08:11:07AM +0100, Andy Shevchenko wrote:
>> > On Fri, 2013-05-24 at 23:55 +0200, Guennadi Liakhovetski wrote:
>> > > On Thu, 23 May 2013, Andy Shevchenko wrote:
>> > >
>> > > > When user interrupts ongoing transfers the dmatest may end up with console
>> > > > lockup, oops, or data mismatch. This patch prevents user to abort any ongoing
>> > > > test.
>> > >
>> > > Personally I would be against such a change. What about interrupting the
>> > > test with rmmod?
>> > >  Is it still possible after this your patch or not? If not
>> > > - this doesn't seem like a good idea to me. Why don't we just fix those
>> > > bugs, that you're describing?
>> >
>> > The behaviour of the module is returned to the same page by this patch
>> > as it was before (w/o debugfs).
>> >
>> > The user can interrupt tests by rmmod, but it will take time up to
>> > timeout.
>> >
>> > I appreciate if you can do a deeper analysis of what happened in
>> > case Will reported.
>>
>> Did this query hold up the application of this patch? I'd really like to see
>> *something* in 3.10, otherwise dmatest will be broken.

Will, Vinod is the slave DMA subsystem maintainer, I hope he could
shed a light on your concerns.
Actually, does it work as expected if you didn't run modprobe -r ?

> Not from me, no. I just expressed a doubt, the author thinks there is no
> problem, and I have no capacity atm to try to verify it, so, my query
> shouldn't be considered a nak.

Guennadi, anyway, thanks for your opinion.

Vinod, have you chance to try last patch?

--
With Best Regards,
Andy Shevchenko
