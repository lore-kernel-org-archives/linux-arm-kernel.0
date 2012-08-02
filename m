From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 2 Aug 2012 07:58:39 +0200
Subject: [PATCH v3 12/32] PCI/ARM: use PCIe capabilities access functions
 to simplify implementation
In-Reply-To: <5019654D.2000408@wwwdotorg.org>
References: <1343836477-7287-1-git-send-email-jiang.liu@huawei.com>
 <1343836477-7287-13-git-send-email-jiang.liu@huawei.com>
 <5019654D.2000408@wwwdotorg.org>
Message-ID: <20120802055839.GA12241@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 11:20:13AM -0600, Stephen Warren wrote:
> On 08/01/2012 09:54 AM, Jiang Liu wrote:
> > From: Jiang Liu <jiang.liu@huawei.com>
> > 
> > Use PCIe capabilities access functions to simplify PCIe ARM implementation.
> > 
> > Signed-off-by: Jiang Liu <liuj97@gmail.com>
> 
> This is probably fine from my perspective assuming the underlying PCI
> API implementation is OKd by relevant people.
> 
> Thierry, can you comment on whether this will conflict with your Tegra
> PCIe driver series? If it doesn't, this patch can go through any
> relevant PCI tree. If it does, we may have to take this through the
> Tegra tree after merging the dependencies, or defer it to later.

I haven't touched those lines. tegra_pcie_relax_enable() only uses
generic PCI functions so I don't expect any conflicts. git blame
confirms that those lines haven't been changed in about 2 years.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120802/eee09477/attachment-0001.sig>
