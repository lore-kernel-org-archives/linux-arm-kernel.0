From: b08248@gmail.com (Stuart Yoder)
Date: Tue, 5 Aug 2014 17:35:04 -0500
Subject: [RFC PATCH 03/11] PCI/MSI: Refactor pci_dev_msi_enabled()
In-Reply-To: <1406344128-27055-4-git-send-email-wangyijing@huawei.com>
References: <1406344128-27055-1-git-send-email-wangyijing@huawei.com>
 <1406344128-27055-4-git-send-email-wangyijing@huawei.com>
Message-ID: <CALRxmdB0Ltt3_G=D4i7x47pHCtCKo8RHgn-hgN+u=px22dimOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 10:08 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> Pci_dev_msi_enabled() is used to check whether device
> MSI/MSIX enabled. Refactor this function  to suuport
> checking only device MSI or MSIX enabled.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

So this patch refactors things so that checks like this:
   > -       if (!dev->msi_enabled)

are moved into a function:
   > +       if (!pci_dev_msi_enabled(dev, MSI_TYPE))

Can you explain a bit more why this  needed.   Is it just cleanup?

Thanks,
Stuart
