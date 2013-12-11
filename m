From: marex@denx.de (Marek Vasut)
Date: Wed, 11 Dec 2013 11:03:28 +0100
Subject: [PATCH 08/12] pcie: designware: Fix IO transfers
In-Reply-To: <6b4282b9e793ec89ba0c20f3362d41f6133a8132.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <6b4282b9e793ec89ba0c20f3362d41f6133a8132.1386752447.git.mohit.kumar@st.com>
Message-ID: <201312111103.28568.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 11, 2013 at 10:38:33 AM, Mohit Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> pp->io_base which is the input of the outbound IO address translation
> unit should be the cpu address, it was programmed wrongly to realio
> address.
> 
> We should pass global_io_offset rather than sys->io_offset to
> pci_ioremap_io, so we map the new window into the first available spot
> in the Linux view of the I/O space.
> 
> We must also pass cpu address instead  of realio address to
> pci_ioremap_io.
> 
> This patch fixes above issue. It has been tested with Lecroy PTC in AIC
> mode and Pericom PI7C9X2G303EL PCIe switch, which does not work
> otherwise.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Tested-by: Mohit Kumar <mohit.kumar@st.com>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> Cc: linux-pci at vger.kernel.org
> Cc: spear-devel at list.st.com

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
