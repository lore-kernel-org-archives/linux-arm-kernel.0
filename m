From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 14 May 2013 15:01:01 +0900
Subject: [PATCH 2/3] ARM: shmobile: r8a7790: Configure R-Car GPIO for
 IRQ_TYPE_EDGE_BOTH
In-Reply-To: <20130514024034.GA20239@verge.net.au>
References: <1368435233-8587-1-git-send-email-horms+renesas@verge.net.au>
 <1368435233-8587-3-git-send-email-horms+renesas@verge.net.au>
 <2257564.fgMO2c8G9k@avalon> <20130514024034.GA20239@verge.net.au>
Message-ID: <CANqRtoR_BGFo+GRgom2WqXnaGtoB1T90S=twO_4G_t-JE8roTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Laurent,

On Tue, May 14, 2013 at 11:40 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, May 14, 2013 at 12:33:42AM +0200, Laurent Pinchart wrote:
>> Hi Simon,
>>
>> On Monday 13 May 2013 17:53:52 Simon Horman wrote:
>> > "gpio-rcar: Support IRQ_TYPE_EDGE_BOTH" adds support to the R-Car GPIO
>> > driver for IRQ_TYPE_EDGE_BOTH. As hardware support for this feature is
>> > not universal for all SoCs a flag, has_both_edge_trigger, has been
>> > added to the platform data of the driver to allow this feature to be
>> > enabled.
>>
>> What about moving this information to a platform ID table in the gpio-rcar
>> driver ?
>
> Magnus, do you have an opinion on this?

I don't mind so much as long as we:
a) can control things freely per driver instance
and
b) don't have to update all drivers for every new SoC

The current approach allows for that, so as an example if we can have
two slightly different GPIO hardware blocks then we can setup two GPIO
controller driver instances where the configuration can be selected
per-instance. Perhaps Laurent's proposal would allow for this too, I'm
not sure.

On top of that I'd like to avoid doing per-SoC string matching in
drivers. Those would force us to update every darn driver for every
new SoC. It is better to try to use a per-hardware device version in
the drivers and then configure each SoC to use the appropriate
version.

Thanks,

/ magnus
