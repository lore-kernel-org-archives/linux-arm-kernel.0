From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Fri, 24 Aug 2012 14:53:15 +0200
Subject: [RFC][PATCH] Disintegrate sharpsl_param.c
In-Reply-To: <20120824112536.GA19675@atrey.karlin.mff.cuni.cz>
References: <1345656424-31234-1-git-send-email-dromede@gmail.com>
 <1345663182.3907.134.camel@ted> <20120824111211.GA28183@elf.ucw.cz>
 <20120824112536.GA19675@atrey.karlin.mff.cuni.cz>
Message-ID: <CAHod+Gc8udMVChaezqte3dEns5E-udduwugL0o_VCYu=UCP9Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 1:25 PM, Cyril Hrubis <metan@ucw.cz> wrote:
> Hi!
>> > > I recently tried running 3.6-rc2 kernel on my Sharp Zaurus C-1000. It
>> > > hanged almost immediately after uncompressing the kernel. I tracked the
>> > > problem down to a single line in arch/arm/common/sharpsl_param.c:
>> > >
>> > > memcpy(&sharpsl_param, (void *)PARAM_BASE, sizeof(struct sharpsl_param_info));
>> > >
>> > > Commenting out the line makes the kernel boot just fine. This left me
>> > > wondering whether sharpsl_param.c is actually needed. Here's a comment
>> > > from sharpsl_param.c that describes what sharpsl_param.c actually does:
>> >
>> > Sharp went to the trouble of saving these values into the hardware and
>> > passing them into the drivers. They're basically used by the LCD
>> > initialisation code from what I remember. I don't remember what the
>> > risks are of incorrect values.
>>
>> We were seeing strange flicker on LCD on some machines...? Particulary
>> metan's machine with wifi on did that. OTOH it looked like some kind
>> of DMA issue.
>
> Yes, the problems with my LCD are DMA related (too much DMA to wifi cf card
> causes timing issues on display refresh). When there is no network activity
> it's okay.
>
> And as far as I remeber there are some magic values needed for the LCD in order
> not to have distorted picture (blurred, etc.) There is a callibration program
> in the service menu that allows you to modify the values stored in the flash.
>
> I remeber Stanislav did some research on that (CCing).
>
> --
> metan
