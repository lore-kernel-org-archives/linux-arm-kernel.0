From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Jun 2012 08:10:03 +0200
Subject: [PATCH v2 06/10] ARM: tegra: pcie: Add MSI support
In-Reply-To: <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
 <4FD660F9.7030807@wwwdotorg.org>
 <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120612061003.GC4040@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thierry Reding wrote:
> * Stephen Warren wrote:
> > On 06/11/2012 09:05 AM, Thierry Reding wrote:
[...]
> > > +static int tegra_pcie_disable_msi(struct platform_device *pdev)
> > 
> > Should this free pcie->msi->pages?
> 
> Yes it should. I actually mention making that change in the changelog but
> in fact didn't.

This is really moot because the driver cannot be built as a module currently
because arch_setup_msi_irq() and arch_teardown_msi_irq() need to be built-in
so tegra_pcie_disable_msi() will be called only just before the machine is
shut down.

Perhaps this is something that should be addressed? Or is it just not worth
the effort?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/92722551/attachment.sig>
