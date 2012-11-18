From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Nov 2012 11:10:16 +0000
Subject: [PATCH v2] Misc: ARM_CHAR_LCD: Permit the use of a driver on
 any ARM machine
In-Reply-To: <1353236200-11435-1-git-send-email-shc_work@mail.ru>
References: <1353236200-11435-1-git-send-email-shc_work@mail.ru>
Message-ID: <20121118111016.GS3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2012 at 02:56:40PM +0400, Alexander Shiyan wrote:
> arm-charlcd driver can be used on any ARM machine, so dependency of
> PLAT_VERSATILE is removed.

This needs a better explanation.  We know that it's used on ARMs
reference boards.  Which other platforms will be making use of this
driver?  Do these other boards implement the same interface, including
the presence of the interrupt?

I'd need to re-read the specs, but I think that the interface this
driver uses is provided by ARMs FPGA rather than the LCD module itself,
and re-use of this driver would need that IP to be implemented elsewhere.
