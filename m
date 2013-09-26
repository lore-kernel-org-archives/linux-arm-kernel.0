From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 26 Sep 2013 11:43:04 +0300
Subject: [PATCH] video: mmp: drop needless devm cleanup
In-Reply-To: <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5243F398.1070705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/09/13 19:13, Uwe Kleine-K?nig wrote:
> The nice thing about devm_* is that the driver doesn't need to free the
> resources but the driver core takes care about that. This also
> simplifies the error path quite a bit and removes the wrong check for a
> clock pointer being NULL.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/mmp/hw/mmp_ctrl.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 

Thanks, queuing for 3.12 fixes.

 Tomi



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130926/a1a59c36/attachment.sig>
