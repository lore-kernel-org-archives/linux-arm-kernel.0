From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 7 Aug 2010 17:06:17 +0800
Subject: [PATCH 07/11] [ARM] pxa/balloon3: Machine file cleanup
In-Reply-To: <201008062347.30423.marek.vasut@gmail.com>
References: <1280920933-3820-1-git-send-email-marek.vasut@gmail.com>
	<201008060949.29366.marek.vasut@gmail.com>
	<20100806195218.GU9577@earth.li>
	<201008062347.30423.marek.vasut@gmail.com>
Message-ID: <AANLkTikpPEKkow_4HwAtc4P+6vzXYUMA6BEw6q5LjnuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 7, 2010 at 5:47 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne P? 6. srpna 2010 21:52:18 Jonathan McDowell napsal(a):
>> On Fri, Aug 06, 2010 at 09:49:29AM +0200, Marek Vasut wrote:
>> > Dne P? 6. srpna 2010 01:25:06 Jonathan McDowell napsal(a):
>> > > On Wed, Aug 04, 2010 at 01:22:09PM +0200, Marek Vasut wrote:
>> > > > Modularize components of the Balloon3 board.
>> > >
>> > > NAK.
>> > >
>> > > That's not what a large portion of this patch does.
>> >
>> > Oh, really ?
>>
>> A large portion of it removes setting the MFPs based on the board
>> capabilities. That's a different piece of work to making the various
>> components modular.
>>
>> > > You have put all of the pin definitions into balloon3_pin_config and
>> > > negated the work that was done to ensure that a single kernel could
>> > > run on different variants of the balloon3.
>> >
>> > I have only this one, but read on.
>>
>> I suspect you have a similar board to me; a double sided board fairly
>> well populated (sound, CF, USB host + slave, LCD). The Lightwriter, for
>> example, is a single sided board using fewer peripherals. The CUED
>> variant I believe is different again for their needs.
>
> That's just great.
>>
>> > > If a feature isn't configured on the board you shouldn't configure
>> > > the MFPs for that feature.
>> >
>> > That's not true. You should configure them as inputs. The big plan (in
>> > another patch) is to do this the same way colibri270 is done (balloon3
>> > baseboard + expansion boards).
>>
>> I don't have a copy of the PXA reference to hand, so I'm happy to accept
>> best practise is to set unused pins to be inputs. However the changes in
>> this patch don't do this and may end up setting some pins that are used
>> for something else to an unexpected output.
>
> The changes in this patch should not screw up anything. If they do break
> something, it'll be eventually found out. Do you have any trouble with this
> patch on your board?
>>
>> I'm failing to understand the motivation for these changes, especially
>> if you have a plan to later do more appropriate cleanup.
>
> Because you can't do everything at once. I prepared the ground for further
> changes.
>
> I wonder why noone actually sent a better patch ever since balloon3 was pushed
> mainline ... that's like 15 kernel versions already, isn't it? I also believe
> this patch will make it very hard to forward-port the out-of-the-tree patches on
> balloon3 website, which are often in terrible shape ... well that's sad.

Well, possibly you can now sleep even less ;-)
