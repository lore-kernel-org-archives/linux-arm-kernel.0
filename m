From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Feb 2012 10:35:18 +0100
Subject: [PATCH] Skip unnecessary pte makeup when clearing it.
In-Reply-To: <4F2B903E.5070609@gmail.com>
References: <1327912567-18966-1-git-send-email-bill4carson@gmail.com>
 <1327912567-18966-2-git-send-email-bill4carson@gmail.com>
 <20120203065432.GG25594@pengutronix.de>
 <4F2B903E.5070609@gmail.com>
Message-ID: <20120203093518.GH25594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 03:43:58PM +0800, bill4carson wrote:
> 
> 
> On 2012?02?03? 14:54, Uwe Kleine-K?nig wrote:
> >Hello,
> >
> >On Mon, Jan 30, 2012 at 04:36:07PM +0800, bill4carson at gmail.com wrote:
> >>From: Bill Carson<bill4carson@gmail.com>
> >>
> >>If we are only about to clear a hardware pte entry, then pte makeup code is
> >>unnecessary for cpu_v7_set_pte_ext and armv6_set_pte_ext, so just skip it.
> >>
> >>Signed-off-by: Bill Carson<bill4carson@gmail.com>
> >I havn't tested and I don't know if the patch brings any advantages like
> >increased speed. But AFAICT it doesn't change the behaviour of
> >armv6_set_pte_ext and cpu_v7_set_pte_ext.
> >
> Hi, Uwe
> 
> I'm sorry I didn't state the purpose of this patch clearly.
> As a matter of fact, it does change the behavior of set_pte_ext :)
Depends on what you call behaviour (and it's not the 'u' you dropped
that makes a difference :-). I meant that the side effects don't change.
It's only that they are accomplished in a different (probably more
effective) way.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
