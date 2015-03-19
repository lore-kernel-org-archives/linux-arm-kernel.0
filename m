From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Mar 2015 09:48:41 +0100
Subject: [PATCH 1/6] clk: make strings in parent name arrays const
In-Reply-To: <1426754530-3137-2-git-send-email-s.hauer@pengutronix.de>
References: <1426754530-3137-1-git-send-email-s.hauer@pengutronix.de>
 <1426754530-3137-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150319084841.GT10068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Mar 19, 2015 at 09:42:05AM +0100, Sascha Hauer wrote:
> The clk functions and structs declare the parent_name arrays as
> 'const char **parent_names' which means the parent name strings
> are const, but the array itself is not. Use
> 'const char * const * parent_names' instead which also makes
> the array const. This allows us to put the parent_name arrays into
> the __initconst section.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
looks sensible:

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

It would be nice to have this for more clock types (which of course
shouldn't delay this patch).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
