From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 21:41:54 +0000
Subject: [PATCH v3 13/24] drm/i2c: tda998x: fix a NULL pointer dereference
In-Reply-To: <20140119195843.59810a46@armhf>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195843.59810a46@armhf>
Message-ID: <20140122214154.GK15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:58:43PM +0100, Jean-Francois Moine wrote:
> This patch fixes a NULL pointer dereference when the set_config
> function has not been called (priv->params == NULL).

No, that's not what this patch is doing.  Maybe you could enlighten me
how priv->params could ever be NULL when that is _not_ a pointer?  That's
completely impossible as it isn't a pointer.

If you tried "priv->params = NULL" the C compiler would barf on it.

I suspect you've misunderstood the code, and this change isn't actually
necessary.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
