From: davem@davemloft.net (David Miller)
Date: Tue, 08 Jul 2014 20:52:08 -0700 (PDT)
Subject: [PATCH resend] net: mvneta: Fix big endian issue in
 mvneta_txq_desc_csum()
In-Reply-To: <m3wqbnpgag.fsf@fitzsim.org>
References: <m3wqbnpgag.fsf@fitzsim.org>
Message-ID: <20140708.205208.1742283754280003313.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Fitzsimmons <fitzsim@fitzsim.org>
Date: Tue, 08 Jul 2014 19:44:07 -0400

> This commit fixes the command value generated for CSUM calculation
> when running in big endian mode.  The Ethernet protocol ID for IP was
> being unconditionally byte-swapped in the layer 3 protocol check (with
> swab16), which caused the mvneta driver to not function correctly in
> big endian mode.  This patch byte-swaps the ID conditionally with
> htons.
> 
> Cc: <stable@vger.kernel.org> # v3.13+
> Signed-off-by: Thomas Fitzsimmons <fitzsim@fitzsim.org>
> ---
> The mvneta driver existed prior to v3.13, but it has only supported big
> endian from v3.13 onward.  If it's accepted, this patch needs to be
> backported for stable only as far back as v3.13.

Applied and queued up for -stable, thanks.
