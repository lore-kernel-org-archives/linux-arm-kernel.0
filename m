From: matt@genesi-usa.com (Matt Sealey)
Date: Tue, 4 Jan 2011 14:03:12 -0600
Subject: [patch 2/5] ulpi: handle ULPI_OTG_CTRL_CHRGVBUS
In-Reply-To: <87sjx8783g.fsf@lechat.rtp-net.org>
References: <20101220154853.254931637@rtp-net.org>
	<20101220155812.122749841@rtp-net.org>
	<4D109C47.6020704@compulab.co.il> <8762ukb67c.fsf@lechat.rtp-net.org>
	<4D14B69D.4030506@compulab.co.il> <87fwta8b99.fsf@lechat.rtp-net.org>
	<4D21D00C.3040601@compulab.co.il> <87bp3y84ng.fsf@lechat.rtp-net.org>
	<4D22D256.2040504@compulab.co.il> <87sjx8783g.fsf@lechat.rtp-net.org>
Message-ID: <AANLkTimWfucS6XqovGDCyVhM20HgKpxCwTOkeHKzqK29@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 4, 2011 at 2:00 PM, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
> Igor Grinberg <grinberg@compulab.co.il> writes:
>
> Adding Matt Sealey in CC:. he's the product development analyst so he
> knows the hardware (unlike me).


>>>> Also, what ulpi vendor/product id is reported in ulpi_init()?
>>> ULPI transceiver vendor/product ID 0x0424/0x0006
>>> Found SMSC USB3319 ULPI transceiver.
>>
>> SMSC USB3319 does not have either an integrated Vbus switch or Charge Pump,
>> For the device connected to that transceiver could work properly,
>> there is a need in _external Vbus switch_ , that should be enabled using
>> some kind of CPEN pin (can be GPIO).
>> This means, that you don't even need to call ulpi_set_vbus().
>>
>> Either way, this patch is NAK.
>> I think you need to check your hardware (in particular Vbus supply).

Hey guys,

On the Smartbook at least both USB host ports (H1 and H2) on the board
(one port each) are connected directly to 4-port USB hubs (SMSC2514).
We don't have anything on there except that connection: the hub should
handle VBUS properly. Both ports use an SMSC3317 (just a 3311 with a
built in 3.3V supply so the id and behavior should be identical).

On the Smarttop H1 is connected to a 4-port USB hub (Terminus FE1.1)
with the same configuration. Same PHY. The DR port is connected
directly to an ASIX ethernet controller. VBUS seems routed to a test
point.

I'm curious exactly what the real problem here is: that VBUS is
basically not being handled correctly? It should be driven or not? I'm
not entirely familiar with the specification.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
