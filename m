From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Aug 2014 09:39:29 +0200
Subject: [PATCH 2/3] ARM: at91/tclib: move initialization from alloc to
 probe
In-Reply-To: <1408486072-19268-3-git-send-email-gael.portay@gmail.com>
References: <1408486072-19268-1-git-send-email-gael.portay@gmail.com>
 <1408486072-19268-3-git-send-email-gael.portay@gmail.com>
Message-ID: <20140820073929.GJ13793@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 12:07:51AM +0200, Ga?l PORTAY wrote:
> Move resource retrieval from atmel_tc_alloc to tc_probe to avoid lately
> reporting resource related issues when a TC block user request a TC block.
> 
> Moreover, resources retrieval are usually done in the probe function,
> thus moving them add some consistency with other drivers.
> 
> Initialization is done once, ie not every time a tc block is requested.
> If it fails, the device is not appended to the list of tc blocks.
> 
> Furhermore, the device id is retrieved at probe as well, avoiding parsing
> DT every time the user requests of tc block.
> 
> Signed-off-by: Ga?l PORTAY <gael.portay@gmail.com>
> ---
>  drivers/clocksource/tcb_clksrc.c |  2 +-
>  drivers/misc/atmel_tclib.c       | 71 +++++++++++++---------------------------
>  drivers/pwm/pwm-atmel-tcb.c      |  2 +-
>  include/linux/atmel_tc.h         |  8 +++--
>  4 files changed, 29 insertions(+), 54 deletions(-)

For the PWM driver part:

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/16a4665b/attachment.sig>
