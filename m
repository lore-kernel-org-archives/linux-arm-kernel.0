From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Feb 2012 07:54:32 +0100
Subject: [PATCH] Skip unnecessary pte makeup when clearing it.
In-Reply-To: <1327912567-18966-2-git-send-email-bill4carson@gmail.com>
References: <1327912567-18966-1-git-send-email-bill4carson@gmail.com>
 <1327912567-18966-2-git-send-email-bill4carson@gmail.com>
Message-ID: <20120203065432.GG25594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jan 30, 2012 at 04:36:07PM +0800, bill4carson at gmail.com wrote:
> From: Bill Carson <bill4carson@gmail.com>
> 
> If we are only about to clear a hardware pte entry, then pte makeup code is
> unnecessary for cpu_v7_set_pte_ext and armv6_set_pte_ext, so just skip it.
> 
> Signed-off-by: Bill Carson <bill4carson@gmail.com>
I havn't tested and I don't know if the patch brings any advantages like
increased speed. But AFAICT it doesn't change the behaviour of
armv6_set_pte_ext and cpu_v7_set_pte_ext.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
