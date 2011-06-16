From: vitalywool@gmail.com (Vitaly Wool)
Date: Thu, 16 Jun 2011 14:20:27 +0200
Subject: [PATCH] omap3evm: Add Mistral WL12XX config support
In-Reply-To: <20110614135518.GH23145@atomide.com>
References: <1308053788-25937-1-git-send-email-shahar@wizery.com>
	<20110614123359.GB23145@atomide.com>
	<BANLkTikE_caRE9uD6KN7h7OcY4nyUoRk9g@mail.gmail.com>
	<20110614135518.GH23145@atomide.com>
Message-ID: <BANLkTi=XocYNPwuB2_-T8AHQkfEuzUnd9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shahar, Tony,

On Tue, Jun 14, 2011 at 3:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Shahar Lev <shahar@wizery.com> [110614 06:21]:
>> On Tue, Jun 14, 2011 at 3:34 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > This your should try to remove as it won't work nicely for supporting
>> > various boards with the same kernel as we already do with
>> > omap2plus_defconfig.
>> >
>> > Can you somehow detect the daughter board dynamically and then
>> > set the flags?
>> >
>>
>> We thought about multi-board kernels, but unfortunately have no
>> better solution, since there is no dynamic way to probe these cards.
>> Even worse, these cards sometimes come with different clocks in them,
>> hence the 2nd OMAP3EVM_MISTRAL_WL12XX_REFCLOCK entry we had to
>> introduce...
>>
>> Maybe we should add two bootargs with which the user can override this
>> Kconfig configuration? This should allow using the same kernel binary
>> with different omap3evm boards.

You won't need Kconfig parameters then. Just have module parameters
and supply whatever default values you find reasonable.

~Vitaly
