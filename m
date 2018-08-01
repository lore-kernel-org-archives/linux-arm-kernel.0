From: colin.king@canonical.com (Colin King)
Date: Wed,  1 Aug 2018 11:47:41 +0100
Subject: [PATCH 8/9] ALSA: usb-audio: remove redundant pointer 'urb'
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Message-ID: <20180801104742.4328-9-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'urb' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'urb' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/endpoint.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index c90607ebe155..d86be8bfe412 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -325,7 +325,6 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 		unsigned long flags;
 		struct snd_usb_packet_info *uninitialized_var(packet);
 		struct snd_urb_ctx *ctx = NULL;
-		struct urb *urb;
 		int err, i;
 
 		spin_lock_irqsave(&ep->lock, flags);
@@ -345,7 +344,6 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 			return;
 
 		list_del_init(&ctx->ready_list);
-		urb = ctx->urb;
 
 		/* copy over the length information */
 		for (i = 0; i < packet->packets; i++)
-- 
2.17.1
