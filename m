From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 23:27:16 +0000
Subject: [PATCH v3 18/24] drm/i2c: tda998x: fix the ENABLE_SPACE register
In-Reply-To: <20140119195845.086be909@armhf>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195845.086be909@armhf>
Message-ID: <20140122232716.GO15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:58:45PM +0100, Jean-Francois Moine wrote:
> This patch fixes the ENABLE_SPACE register, the value of which was
> inverted.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>

I've researched the change to PLL_SERIAL_2, and this is correct.  I think
your change to REG_ENABLE_SPACE is also correct.  This looks like a bug
fix to me, so maybe consider having it applied to previous kernel
versions as well?

Also... please try putting yourself in the position of a reviewer of your
own patches - read the patch and then read the description, and ask whether
the description is adequate for the patch... the description talks just
about the ENABLE_SPACE register.  But what about the PLL_SERIAL_2 register
changes?  They're *totally* not described.

Hence...

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

and no acked-by.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
