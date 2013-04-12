From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Apr 2013 10:51:13 +0200
Subject: [PATCH 11/11] RFC: ARM: get PCI device IRQs from device tree
In-Reply-To: <20130412082229.GA30593@arm.com>
References: <1365087696-9548-4-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-5-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-6-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-7-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-8-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-9-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-10-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-11-git-send-email-linus.walleij@linaro.org>
 <1365087696-9548-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZhPYqxgUuffTabN+RZkTBY2w0t-OmJ8Wsew8qOWTRQ7A@mail.gmail.com>
 <20130412082229.GA30593@arm.com>
Message-ID: <CACRpkdbTKoVMx6mH0sgjJLEFFbDC6u0_HH+79PK2D+=H_FPXfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 10:22 AM, Andrew Murray <andrew.murray@arm.com> wrote:

Thanks for your prompt reply Andrew!

> I don't think any of these solutions are ideal - perhaps pcibios_init_hw needs
> to be changed... there are patches around which involve passing additional
> private data in sys_data/hw_pci see [1] and [4] if this additional data
> contains struct device or struct device_node then perhaps they can be plumbed
> into the default call to pci_scan_root_bus in bios32? If every ARM DT host
> bridge driver needs to implement their own scan function then something isn't
> quite right.

So yesterday I came up with the scheme of augmenting the
pci_common_init() call in bios32.c to take an additional struct device *parent
argument, then pass that to the pci_create_root_bus() call, as it is hard-coded
to NULL in bios32.c today. Current users were patched to pass NULL
as parent.

When you assign that from a struct device* instatiated from the device tree the
node gets properly resolved and the mappings start to work.

However I might have been too sleepy last night and misfired the patch since
it seems it has not yet made it onto the mailing list ... will resend.

Yours,
Linus Walleij
