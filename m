From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 23 Mar 2018 10:53:04 +0100
Subject: [PATCH 01/10] drm/sun4i: Disable frontend video channel before
 enabling a layer
In-Reply-To: <20180321152904.22411-2-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-2-paul.kocialkowski@bootlin.com>
Message-ID: <20180323095304.zfvusbsteykne4vt@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 04:28:55PM +0100, Paul Kocialkowski wrote:
> This adds a dedicated function for disabling the layer video channel
> from the frontend to the backend. It is called automatically on an
> atomic update, as to disable the frontend by default (it will be enabled
> later on in the atomic update if necessary).
> 
> It fixes an issue when enabling a layer that uses the frontend (e.g. for
> scaling) and then reusing the same layer without the frontend. Since the
> video channel to the frontend was never disabled, the backend was still
> trying to get data from there.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
