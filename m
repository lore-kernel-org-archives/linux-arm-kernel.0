From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 18:58:36 +0200
Subject: [PATCH] pinctrl: imx5: fix SD2_DATA1 pad AUDMUX_AUD4 configuration
In-Reply-To: <20130403083846.GQ24039@S2101-09.ap.freescale.net>
References: <1364882642-25574-1-git-send-email-marex@denx.de>
 <201304030221.18506.marex@denx.de>
 <20130403052423.GO24039@S2101-09.ap.freescale.net>
 <201304030852.52125.marex@denx.de>
 <20130403083846.GQ24039@S2101-09.ap.freescale.net>
Message-ID: <CACRpkdZpM6z5CDRNXOape_kJShBxSKNvUV0L6cosER16Sn6NbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 3, 2013 at 10:38 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Apr 03, 2013 at 08:52:51AM +0200, Marek Vasut wrote:
>> Dear Shawn Guo,
>>
>> > On Wed, Apr 03, 2013 at 02:21:18AM +0200, Marek Vasut wrote:
>> > > One serving of such patch, coming right up ;-)
>> > >
>> > > btw. do you want to apply this one for -stable or do we just leave it as
>> > > is ?
>> >
>> > If you do not insist, I would say let's leave it as it is, as we
>> > encourage people to upgrade device tree to adopt the new pinctrl
>> > binding.
>>
>> Actually, I have a bad feeling about having an open bug in stable tree. Someone
>> might use that tree and might try to use AUDMUX4 on his (out-of-tree) device and
>> might run into the same problem. Three times 'might' in one sentence doesn't
>> make it sound too likely, but if you have not much trouble with getting it in -
>> stable, please try to.
>
> Ok, it's Linus' call then, since it's a fix that should go via pinctrl
> tree.  Since I will not be able to rebase my 3.10 stuff on -rc7, if the
> patch does not catch up with -rc6, we run into a annoying merge
> conflict during the merge window.

Basically I'm not keen on sending any DT patches as fixes, DT
is at one time supposed to be moved out of the kernel even. I don't
think it qualifies for fixes this late in the merge window.

Besides it's not in a part of the file hierarchy I maintain so I
strongly prefer pure DT patches to go in from the platform trees.
(Subject should be ARM: imx ...)

Please carry this patch in the Freescale tree.

Yours,
Linus Walleij
