From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 20 Jul 2011 17:14:05 -0600
Subject: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
In-Reply-To: <20110720223348.GH6999@S2100-06.ap.freescale.net>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
	<1309426647-31587-2-git-send-email-manjugk@ti.com>
	<20110706185546.GJ4871@ponder.secretlab.ca>
	<74CDBE0F657A3D45AFBB94109FB122FF049E21C203@HQMAIL01.nvidia.com>
	<CACxGe6u8qq7FA7kFXbU5uCk6m_GA8GWLqsdjFCXN+NMJfFKxmA@mail.gmail.com>
	<20110720110419.GA6999@S2100-06.ap.freescale.net>
	<20110720185513.GI4642@ponder.secretlab.ca>
	<20110720223348.GH6999@S2100-06.ap.freescale.net>
Message-ID: <CACxGe6utwx_LpMx0sqfuTRLst1-0eoi8ZrwA2ZVRyjiVzxKT1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 4:33 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Wed, Jul 20, 2011 at 12:55:13PM -0600, Grant Likely wrote:
>> On Wed, Jul 20, 2011 at 07:04:20PM +0800, Shawn Guo wrote:
>> > > Mostly consistency. ?Most of the experience we have with the flattened
>> > > device tree up to this point hasn't bothered with the 'status'
>> > > property. ?It is only when AMP and hypervisors cam online that it
>> > > became important to use a status property, and that only when the
>> > > kernel needs to be told that the device does indeed exist, but it must
>> > > not be touched. ?I'd like to continue that pattern for new DT users
>> > > with the default assumption that a device is enabled unless the board
>> > > .dts explicitly disables it.
>> [...]
>> > Besides the bothering that we have to list so many unused controllers
>> > in individual board dts file, it's also hard to tell which controllers
>> > are actually available on the board. ?People have to look at imx53.dts
>> > to get a full list and then exclude the ones in imx53-<board>.dts as
>> > "disabled".
>> >
>> > And if we go the way opposite, adding "disabled" status for everyone
>> > in imx53.dts, we will only need to specify the peripherals that are
>> > actually available on board with "okay" status in imx53-<board>.dts.
>> > And it's much more clear for people to see what peripherals are
>> > available on individual board.
>> >
>> > So I'm going the way than you suggested. ?Please let me know if you
>> > strongly dislikes it.
>>
>> Yes, I strongly dislike it. ?I understand the concern, but at this
>> early stage with converting to device tree I think consistency between
>> platforms is more important. ?We can talk about the issue at Linaro
>> Connect in 2 weeks, but in the mean time please use the
>> enabled-by-default/explicitly-disabled pattern.
>>
> Okay, hope you will not ask me to use the opposite pattern when you
> actually see the patch :)

:-)

g.
