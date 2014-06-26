From: ezequiel@vanguardiasur.com.ar (Ezequiel =?iso-8859-1?Q?Garc=EDa?=)
Date: Thu, 26 Jun 2014 13:37:07 -0300
Subject: [PATCH] arm: mach-omap2: gpmc: ignore non-available nodes
In-Reply-To: <1403794923-19511-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1403794923-19511-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <20140626163707.GA26836@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 Jun 12:02 PM, Guido Mart?nez wrote:
> Currently, child nodes of the gpmc node are iterated and probed
> regardless of their 'status' property. This means adding 'status =
> "disabled";' has no effect.
> 
> This patch changes the iteration to only probe nodes marked as
> available.
> 
> Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>

Just a nit: the commit title doesn't match the recent commits. If you
run "git log" on this file, you'll find the pattern should be something
like:

"ARM: OMAP2+: GPMC should only probe enabled devices"

Other than this, the patch looks correct.

Thanks,
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
