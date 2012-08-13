From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 13 Aug 2012 16:37:38 -0500
Subject: [PATCH 1/2] ARM: mach-imx: Remove board entries in dt_board_compat
In-Reply-To: <201208131718.14546.marex@denx.de>
References: <1339941856-2836-1-git-send-email-festevam@gmail.com>
 <20120705074623.GG10610@S2101-09.ap.freescale.net>
 <20120813151509.GB27393@S2101-09.ap.freescale.net>
 <201208131718.14546.marex@denx.de>
Message-ID: <CAKGA1bmYyvW6pWEbLGwRc-H2uWOF19nAt-de-WBqvhbOrGDqMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 10:18 AM, Marek Vasut <marex@denx.de> wrote:
> Dear Shawn Guo,
>
>> On Thu, Jul 05, 2012 at 03:46:23PM +0800, Shawn Guo wrote:
>> > On Thu, Jul 05, 2012 at 09:13:18AM +0200, Sascha Hauer wrote:
>> > > Shawn,
>> > >
>> > > Is this ok with you?
>> >
>> > No.
>> >
>> > http://thread.gmane.org/gmane.linux.ports.arm.kernel/172558/focus=172703
>>
>> I change my mind.  Though it's really a pity to lose a concentrated
>> place maintaining a full list of compatible strings of all supported
>> board, I'm more concerned by the dt_board_compat matching efficiency
>> when the table gets longer.
>>
>> So, Fabio, can you please resend the patches against v3.6-rc?
>
> What about the board quirks that are present there?

They don't need to be done since they're usually driver-specific or
unit-specific; DTs should include these at the appropriate places. For
the MX51 Babbage entry all it did was set up all the iomux which is
now done via pinctrl and DT, so it can go. The rest, well, this is
more a quirk of the chip, and what should happen is, if it can be
moved to a bootloader, do it, and set up a quirk as a property in that
device like fsl,mc13xxx-uses-rtc - although in that particular example
I dare say that should be an rtc node under the pmic entry rather than
a property, at least for now it shows you can pick up a property that
changes the behavior of a device without it being in a mach-specific
file.

There may actually be some boards that need some specific, low-level
hacks to make work that will need entering but, for now, this doesn't
need to be. They can be removed and when those specific hacks appear,
their compatibles and new code to support the hacks can be added back
in.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
