From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 13 May 2010 15:00:03 +0100
Subject: OTG implementation with external transceiver on PXA270
In-Reply-To: <87mxw5yo6e.fsf@free.fr>
References: <AANLkTim7lTbhu97hy3tiSXVpkQKr5X6YpU8zSUiVarca@mail.gmail.com>
	<AANLkTikw_VJog3nxH6lcJT4mRJbBcEju-2u6HFpdH3cv@mail.gmail.com>
	<87mxw5yo6e.fsf@free.fr>
Message-ID: <20100513140003.GA23183@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 08:23:21PM +0200, Robert Jarzmik wrote:
> Eric Miao <eric.y.miao@gmail.com> writes:

> That seems a good idea.
> If you expand it further, you could design the full OTG framework :
>  - extend otg.c, add the OTG state machine
>  - extend otg.h and otg.c with new calls :
>    - otg_set_state()
>    - otg_get_state()
>    - otg_signal_udc()
>  - extend otg.h, with callbacks like :
>    - otg_handle_interrupt()

> Separate the isp1301 driver from pxa270. The link will be done through the OTG
> framework. Remember the pxa270 has taken the udc IO space, so no access can be
> done from the isp1301 side (it should not actually for clean separation).

> But that could be more or less what you were thinking about.

This would be really good, not just for OTG but for USB in general -
there's other devices which could make use of information like PMICs
doing regulation of power draw from/to USB.
