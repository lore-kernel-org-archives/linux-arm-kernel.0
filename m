From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 31 Jan 2012 11:27:40 +0100
Subject: [PATCH v2 7/7] LPC32xx: clock.c: Fix mutex lock issues
In-Reply-To: <1327939327-7799-7-git-send-email-stigge@antcom.de>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
 <1327939327-7799-7-git-send-email-stigge@antcom.de>
Message-ID: <20120131102740.GI2471@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 05:02:06PM +0100, Roland Stigge wrote:
> This patch fixes the mutex issue in clock.c, as done in Kevin Wells' original
> driver update:
> 
> In some cases, the clock drivers could grab a mutex twice in an improper
> context. This patch changes the mutex mechanism to a simple irq lock/unlock
> mechanism and removes un-needed locks from some functions.
> 
> (See also git.lpclinux.com)
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/31311eff/attachment.sig>
