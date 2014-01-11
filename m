From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 17:23:23 +0000
Subject: [PATCH v2 9/28] drm/i2c: tda998x: don't read write-only registers
In-Reply-To: <20140109115941.30e67a37@armhf>
References: <20140109115941.30e67a37@armhf>
Message-ID: <20140111172323.GV15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:59:41AM +0100, Jean-Francois Moine wrote:
> This patch takes care of the write-only registers of the tda998x.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

It would be worth commenting that where bit settings are unknown, they
are taken from the default values in the available public data.  I
refer to (for example) the addition of MAT_CONTRL_MAT_SC(1) to the
REG_MAT_CONTRL register in this patch.

The other register ordering changes should also be documented.

However, in my brief test, I haven't noticed any visible detrimental
effects.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
