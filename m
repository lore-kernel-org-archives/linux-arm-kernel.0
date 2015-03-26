From: yinghai@kernel.org (Yinghai Lu)
Date: Thu, 26 Mar 2015 09:31:58 -0700
Subject: [PATCH v8 10/30] PCI: Introduce pci_host_bridge_list to manage
 host bridges
In-Reply-To: <1427168064-8657-11-git-send-email-wangyijing@huawei.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
 <1427168064-8657-11-git-send-email-wangyijing@huawei.com>
Message-ID: <CAE9FiQVgXfViM22qhB-sKDSTtnhvLDMk0NTiK_G88UogVMuM_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 8:34 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> Introduce pci_host_bridge_list to manage pci host
> bridges in system, this make us have the ability
> to check whether the new host would conflict with
> existing one. Then we could remove bus alreay exist
> check in __pci_create_root_bus().

Can we use bus_type instead?
Then we can use bus_find_device for the host_bridge enumeration.

Please refer the patches that I sent out couple years ago.

Thanks

Yinghai
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pci_host_bridge_bus_type_1.patch
Type: text/x-patch
Size: 2397 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150326/bc6099b0/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: for_each_pci_host_bridge.patch
Type: text/x-patch
Size: 3445 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150326/bc6099b0/attachment-0001.bin>
