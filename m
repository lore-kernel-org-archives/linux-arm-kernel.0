From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Jun 2012 23:33:58 -0600
Subject: [PATCH v2 06/10] ARM: tegra: pcie: Add MSI support
In-Reply-To: <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
 <4FD660F9.7030807@wwwdotorg.org>
 <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
Message-ID: <4FD6D4C6.2080201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 11:07 PM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 06/11/2012 09:05 AM, Thierry Reding wrote:
>>> This commit adds support for message signaled interrupts to the
>>> Tegra PCIe controller. Based on code by Krishna Kishore
>>> <kthota@nvidia.com>.
...
>> Why allocate pcie->msi separately; why not include the fields
>> directly into struct tegra_pcie_info *pcie?
...
> Second, and more importantly, this will keep the size of struct 
> tegra_pcie_info smaller if PCI_MSI is not selected because there is
> just one unused pointer instead of five unused fields.

Well, you can always ifdef out the structure fields too, right?
