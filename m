From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Jun 2012 07:41:31 +0200
Subject: [PATCH v2 06/10] ARM: tegra: pcie: Add MSI support
In-Reply-To: <4FD6D4C6.2080201@wwwdotorg.org>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
 <4FD660F9.7030807@wwwdotorg.org>
 <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
 <4FD6D4C6.2080201@wwwdotorg.org>
Message-ID: <20120612054131.GA4040@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 06/11/2012 11:07 PM, Thierry Reding wrote:
> > * Stephen Warren wrote:
> >> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> >>> This commit adds support for message signaled interrupts to the
> >>> Tegra PCIe controller. Based on code by Krishna Kishore
> >>> <kthota@nvidia.com>.
> ...
> >> Why allocate pcie->msi separately; why not include the fields
> >> directly into struct tegra_pcie_info *pcie?
> ...
> > Second, and more importantly, this will keep the size of struct 
> > tegra_pcie_info smaller if PCI_MSI is not selected because there is
> > just one unused pointer instead of five unused fields.
> 
> Well, you can always ifdef out the structure fields too, right?

Not if you use the IS_ENABLED() macro. It's supposed to increase compile
coverage for a trade-off in memory usage because like in this case some
fields may be unused.

I find this very convenient because it prevents situations where build
errors don't show up until somebody uses the code in an unusual
configuration. For developers this makes it really easy because they don't
have to test every possible permutation of configuration options.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/2e8846d7/attachment.sig>
