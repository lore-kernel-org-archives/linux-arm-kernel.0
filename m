From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 3 Aug 2017 17:15:46 -0500
Subject: [PATCH v2 1/5] PCI: mediatek: Add a structure to abstract the
 controller generations
In-Reply-To: <948f9bd0881402d13e6913ad425e7dff50f3fcfc.1501122135.git.honghui.zhang@mediatek.com>
References: <cover.1501122135.git.honghui.zhang@mediatek.com>
 <948f9bd0881402d13e6913ad425e7dff50f3fcfc.1501122135.git.honghui.zhang@mediatek.com>
Message-ID: <20170803221546.GL20308@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 10:58:35AM +0800, honghui.zhang at mediatek.com wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> Introduce a structure "mtk_pcie_soc" to abstract the differences between
> controller generations, and the .startup() hook is used to encapsulate
> some SoC-dependent related setting. In doing so, the common code which
> will be reused by future chips.
> 
> In addition, we change the approaches to waiting Gen2 training by using
> readl_poll_timeout() calls.

Please split the Gen2 training change to a separate patch, since
that's not related to the mtk_pcie_soc changes.
