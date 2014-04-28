From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 28 Apr 2014 19:06:59 +0200
Subject: [PATCH v2 1/7] pinctrl: berlin: add the core pinctrl driver for
 Marvell Berlin SoCs
In-Reply-To: <535B79C6.7010502@gmail.com>
References: <1398268276-9696-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398268276-9696-2-git-send-email-antoine.tenart@free-electrons.com>
 <535B79C6.7010502@gmail.com>
Message-ID: <20140428170659.GC4211@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Sat, Apr 26, 2014 at 11:17:58AM +0200, Sebastian Hesselbarth wrote:
> On 04/23/2014 05:51 PM, Antoine T?nart wrote:
> > The Marvell Berlin boards have a group based pinmuxing mechanism. This
> > adds the core driver support. We actually do not need any information
> > about the pins here and only have the definition of the groups.
> > 
> > Let's take the example of the uart0 pinmuxing on the BG2Q. Balls BK4 and
> > BH6 are muxed to respectively UART0 RX and TX if the group GSM12 is set
> > to mode 0:
> > 
> > Group	Modes	Offset Base	Offset	LSB	Bit Width
> > GSM12	3	sm_base		0x40	0x10	0x2
> > 
> > Ball	Group	Mode 0		Mode 1		Mode 2
> > BK4	GSM12	UART0_RX	IrDA0_RX	GPIO9
> > BH6	GSM12	UART0_TX	IrDA0_TX	GPIO10
> > 
> > So in order to configure BK4 -> UART0_TX and BH6 -> UART0_RX, we need
> > to set (sm_base + 0x40 + 0x10) &= ff3fffff.
> > 
> > Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> 
> Antoine,
> 
> I only have some cosmetic nits on the pinctrl driver and one fixup for
> the dts.
> 
> If you resend, feel free to add my
> 
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Will do. Thanks for the review!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
