From: bp@alien8.de (Borislav Petkov)
Date: Fri, 9 Jun 2017 15:37:02 +0200
Subject: [RFC PATCH 0/7] EDAC drivers for Armada XP L2 and DDR
In-Reply-To: <1497014628.3536.60.camel@pengutronix.de>
References: <20170609083123.6539-1-jlu@pengutronix.de>
 <20170609093651.nfhthfdjn2jfkpxx@pd.tnic>
 <1497014628.3536.60.camel@pengutronix.de>
Message-ID: <20170609133702.avtdlmdx42rptyc4@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 03:23:48PM +0200, Jan L?bbe wrote:
> The L2 cache and DDR RAM controller are completely separate IP cores,
> with separate register spaces, interrupts and so on. The cache is an ARM
> design (some L2x0) extended by Marvell, while the DDR controller seems
> to be unique to Marvell. It wouldn't surprise me if Marvell would decide
> to reuse the DDR controller in another SoC using newer ARM cores with a
> different cache.

That's fine, we can carve it out then. We've done stuff like that
already, see drivers/edac/fsl_ddr_edac.c, for example.

So think of an EDAC driver as a platform driver. If a platform uses IP
from a different platform, then we mirror this in the driver design by
sharing compilation modules.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
