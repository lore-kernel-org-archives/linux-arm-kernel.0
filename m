From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Aug 2016 19:09:34 +0100
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l, ldr_l and str_l
 macros
In-Reply-To: <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160803180934.GK1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2016 at 05:38:43PM +0200, Ard Biesheuvel wrote:
> +	add	\dst, pc, #:pc_g0_nc:(\sym) - 8
> +	add	\dst, \dst, #:pc_g1_nc:(\sym) - 4
> +	add	\dst, \dst, #:pc_g2:(\sym)

What's this :pc_g0_nc: stuff?  What binutils versions is it supported
in?  It doesn't appear documented in gas 2.23.91, so I don't think we
can use it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
