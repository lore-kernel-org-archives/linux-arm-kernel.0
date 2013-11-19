From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Nov 2013 10:28:19 +0100
Subject: [PATCH v3] ARM: signal: fix armv7-m build issue in
 sigreturn_codes.S
In-Reply-To: <1384843790-14394-2-git-send-email-victor.kamensky@linaro.org>
References: <1384843790-14394-1-git-send-email-victor.kamensky@linaro.org>
 <1384843790-14394-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20131119092819.GD28642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 18, 2013 at 10:49:50PM -0800, Victor Kamensky wrote:
> After "ARM: signal: sigreturn_codes should be endian neutral to
> work in BE8" commit, thumb only platforms, like armv7m, fails to
> compile sigreturn_codes.S. The reason is that for such arch
> values '.arm' directive and arm opcodes are not allowed.
> 
> Fix conditionally enables arm opcodes only if no CONFIG_CPU_THUMBONLY
> defined and it uses .org instructions to keep sigreturn_codes
> layout.
> 
> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Tested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards and thanks
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
