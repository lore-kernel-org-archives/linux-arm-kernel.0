From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Dec 2011 21:11:00 +0000
Subject: [PATCH 02/12] arm/mxs: convert platform code to
 clk_prepare/clk_unprepare
In-Reply-To: <201112201444.40509.marek.vasut@gmail.com>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <1324382443-4439-3-git-send-email-shawn.guo@linaro.org>
 <201112201444.40509.marek.vasut@gmail.com>
Message-ID: <20111220211100.GE2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 02:44:40PM +0100, Marek Vasut wrote:
> I still wonder how to handle the DUART -- amba-pl011 -- maybe we should
> toggle the clock here too ?

amba-pl011, along with all the other Primecells and a few other devices,
have already been converted to use clk_prepare() in the appropriate
places.  See the bunch of commits from
7ff6bcf048e6a9849ea0b44269fa4c1c72869db2 to (and including)
40d3e0f4942ec12c4521fe1b2a2b774164cd2c80.
