From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Tue, 13 Nov 2012 14:12:02 +0900
Subject: [PATCH 1/2] ARM: kirkwood: Add Plat'Home OpenBlocks A6 support
In-Reply-To: <20121112211958.GU24583@lunn.ch>
References: <1352720819-21923-1-git-send-email-iwamatsu@nigauri.org>
 <20121112120535.GA22029@lunn.ch>
 <CABMQnVK5SbT5mbugruZdNursXQiWJOQD4sreEMS1v6GO7PH0mw@mail.gmail.com>
 <20121112211958.GU24583@lunn.ch>
Message-ID: <CABMQnV+_yGiyNntBkFabsjwC=oj7UR-d4zWiSjm2XkZBKEr8cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Andrew.

On Tue, Nov 13, 2012 at 6:19 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Nobuhiro
>
>> >> +     model = "Plat'Home OpenBlocksA6";
>> >> +     compatible = "plathome,openblocks-a6", "marvell,kirkwood-88f6283", "marvell,kirkwood";
>> >
>> > Ah, interesting. A 88f6283. I'm a bit surprised this actually works!
>> > This variant is not listed in kirkwood_id(). So do you see messages
>> > like:
>> >
>> > "Device-Unknown"
>> >
>> > and
>> >
>> > "MPP setup: unknown kirkwood variant"
>>
>> No, I can not see these message.
>> 88f6283 is same as MV88F6282-Rev-A1. Because this has same CPU ID as
>> MV88F6282-Rev-A1.
>
> Ah. O.K.
>
> Is it pin compatible? Please take a look at
>
> https://github.com/lunn/linux/blob/v3.7-rc2-pinctrl-v2/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
>
> and see if what is valid for 88f6282 is also valid for 88f6283.
>
> If its not compatible, we need to add this variant to the table.

I confirmed datasheet.
Yes, 88f6283 is pincompatible as 88f6282. 88f6283 does the clock down
of the 88f6282.

>
>> What kind of value should I set here?
>
> For the moment, keep to 88f6283. At the moment its not actually used.
> However, when we add pinctrl we will need to this about this some
> more, depending on if its pin compatible or not.

OK, I keep  to 88f6283.

>
>> >> +static unsigned int openblocks_a6_mpp_config[] __initdata = {
>> >> +     MPP0_NF_IO2,
>> >> +     MPP1_NF_IO3,
>> >> +     MPP2_NF_IO4,
>> >> +     MPP3_NF_IO5,
>> >> +     MPP4_NF_IO6,
>> >> +     MPP5_NF_IO7,
>> >> +     MPP6_SYSRST_OUTn,
>> >> +     /* MPP7_GPO, */
>> >
>> > Any reason not to actually have MPP7_GPO here?
>> > Is it being used as a GPO line?
>>
>> Yes. MPP7 is assigned to GPO in this target boatd.
>> And GPO is not used.
>> The following is also the same.
>> If unnecessary, I will delete these lines.
>
> If they are not used, i would not list them.
>

OK, I will remove.

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
