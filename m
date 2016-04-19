From: martinayotte@gmail.com (martinayotte at gmail.com)
Date: Tue, 19 Apr 2016 07:46:08 -0700 (PDT)
Subject: [PATCH v1 1/1] add missing UARTs pins for AllWinner H3 DTS +
 add new I2C entries for AllWinner H3 DTS
In-Reply-To: <CAGb2v67e_F1=VaY7ovzW7Whc2ToJU3YabeT-orrLTb0Pouhw_Q@mail.gmail.com>
References: <8673D89D449742EAB9F6EBD05655A295@GirolesWin7>
 <CAGb2v67e_F1=VaY7ovzW7Whc2ToJU3YabeT-orrLTb0Pouhw_Q@mail.gmail.com>
Message-ID: <21e74cd8-2ec7-4fd3-aa5c-ba4eed29a6ab@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ChenYu,

Thanks for your comments.

On Tuesday, April 19, 2016 at 7:11:50 AM UTC-4, Chen-Yu Tsai wrote:
> Hi,
> 
> >  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts  | 36 ++++++++++++++
> >  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 36 ++++++++++++++
> >  arch/arm/boot/dts/sun8i-h3.dtsi            | 75
> 
> First of all, you are touching 3 different files here. These should
> be separate patches.

I'm trying to understand you here, but I can't. Those 3 files changed are related each other. I could have separated the UART changes from I2C changes, but still those 3 files would have been modified at the same time for a single commit and "git patch-format" would still have created a single patch for the 3 files commit. 

Seeing all the patches that coming into the mailing lists, all of them contains multiple files patches, why should it be different here ?

> 
> Secondly, our policy is to not have a default function for generic GPIO pins.
> 

If this is the official policy, then why so many DTS currently present are not following the same rules, such sun6i-a31-hummingbird, sun7i-a20-olinuxino-micro, sun7i-a20-mk808c, sun7i-a20-cubietruck and so many others ?

I thought the rules were there to make DTS the most default common usage definitions for most end-users in a general availability. 
Then, if someone is really in shortage of GPIOs, they could easily turn them back to "disabled" state.

Regards,
Martin.
