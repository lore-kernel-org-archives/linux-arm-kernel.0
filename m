From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 27 Nov 2014 18:09:49 +0200
Subject: [PATCH 16/23] ARM: OMAP4: omapdss: remove legacy pad muxing
 support
In-Reply-To: <1417103514-17027-17-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
 <1417103514-17027-17-git-send-email-t-kristo@ti.com>
Message-ID: <54774CCD.5060600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/14 17:51, Tero Kristo wrote:
> OMAP4 is DT only now, so the legacy mux support is not needed anymore.
> Padconf is used instead from the driver / DT. This removes the need
> for having the mux APIs exported from the control module driver.

We still use those mux functions for DT. The mux registers for DSI are
so funny that we can't use the normal padconf for them.

I did do some work to use syscon, but I never had time to finish it.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/c0cdf318/attachment.sig>
