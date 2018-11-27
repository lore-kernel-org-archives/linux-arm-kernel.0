From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:31:11 +0100
Subject: [PATCH v2 01/43] drm/sun4i: Cleanup video/YUV source before
 enabling a layer
In-Reply-To: <20181123092515.2511-2-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-2-paul.kocialkowski@bootlin.com>
Message-ID: <20181127083111.labwbcven737dnwl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:33AM +0100, Paul Kocialkowski wrote:
> This adds a dedicated function for cleaning the video and YUV source
> channel layer enable bits. This function is called first on layer atomic
> update to make sure that there are no leftover bits from previous
> plane configuration that were not cleaned until now.
> 
> It fixes issues when alternating between video and YUV planes, where
> both bits would be set eventually, leading to broken plane display.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/a6f615da/attachment.sig>
