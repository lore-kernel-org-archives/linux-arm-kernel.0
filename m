From: sourav.poddar@ti.com (Poddar, Sourav)
Date: Wed, 11 Apr 2012 14:34:47 +0530
Subject: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
In-Reply-To: <20120411085638.GC12064@arwen.pp.htv.fi>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
 <20120410162353.GA6217@core.coreip.homeip.net>
 <CAKdam57PkBQXTHv3VZ79vQ_v4TZYLxKCP4FY01XFEQJ-PPLkuQ@mail.gmail.com>
 <20120411085638.GC12064@arwen.pp.htv.fi>
Message-ID: <CAKdam56OpU=CwnnVtGKd=_1vdj481JXEzzip+y4HBGMoEdYPcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Wed, Apr 11, 2012 at 2:26 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Apr 11, 2012 at 02:19:48PM +0530, Poddar, Sourav wrote:
>> >> +static int kbd_readl(struct omap4_keypad *keypad_data, u32 offset)
>> >> +{
>> >> + ? ? if (keypad_data->revision == KBD_REVISION_OMAP4)
>> >> + ? ? ? ? ? ? return __raw_readl(keypad_data->base + offset);
>> >> + ? ? else if (keypad_data->revision == KBD_REVISION_OMAP5)
>> >> + ? ? ? ? ? ? return __raw_readl(keypad_data->base + offset + 0x10);
>> >> +
>> >> + ? ? return -ENODEV;
>> >
>> > Instead do:
>> >
>> > ? ? ? ?return __raw_readl(keypad_data->base + keypad_data->reg_offset +
>> > ? ? ? ? ? ? ? ? ? ? ? ? ? offset);
>> >> +}
>> I have a couple of doubts on this:
>> 1. Before using kbd_readl/kbd_write anywhere we
>> need to populate the "keypad_data->reg_offset" ?with the register address
>> which we need to read or write.
>
> no no... keypad_data->reg_offset would be 0 or 0x10 depending on the
> scheme you decode from revision.
Ohk. Got it. Will make the necessary changes.
Thanks.

~Sourav
>
> --
> balbi
