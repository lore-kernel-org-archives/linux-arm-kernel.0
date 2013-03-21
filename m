From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 21 Mar 2013 10:35:39 -0400
Subject: [PATCH 05/16] thermal: mvebu: Fix valid check for thermal register
In-Reply-To: <1363818997-23137-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130321143539.GV13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

On Wed, Mar 20, 2013 at 07:36:26PM -0300, Ezequiel Garcia wrote:
> The correct value is obtain by first shifting the register by the offset,
> later applying the valid mask and finally invert the result.
> This check was lacking an extra parenthesis to be strictly correct.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/thermal/mvebu_thermal.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

For the next version of this series, could you please put this fix first
in the series?  In this state, it can't be applied to v3.9-rcX, nor
-stable.

thx,

Jason.
