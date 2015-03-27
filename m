From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 27 Mar 2015 10:31:29 +0800
Subject: [PATCH v8 10/30] PCI: Introduce pci_host_bridge_list to manage
 host bridges
In-Reply-To: <CAE9FiQVgXfViM22qhB-sKDSTtnhvLDMk0NTiK_G88UogVMuM_w@mail.gmail.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>	<1427168064-8657-11-git-send-email-wangyijing@huawei.com>
 <CAE9FiQVgXfViM22qhB-sKDSTtnhvLDMk0NTiK_G88UogVMuM_w@mail.gmail.com>
Message-ID: <5514C101.8070705@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/27 0:31, Yinghai Lu wrote:
> On Mon, Mar 23, 2015 at 8:34 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Introduce pci_host_bridge_list to manage pci host
>> bridges in system, this make us have the ability
>> to check whether the new host would conflict with
>> existing one. Then we could remove bus alreay exist
>> check in __pci_create_root_bus().
> 
> Can we use bus_type instead?
> Then we can use bus_find_device for the host_bridge enumeration.
> 
> Please refer the patches that I sent out couple years ago.

HI Yinghai,
   I think your changes is good, but in this series, we only iterate the pci_host_bridge
in drivers/pci/host-bridge.c. The simple list is enough, of course, if we want to export
this list and support to host bridge hotplug, we must need a new iteration for host bridge,
and your series looks good to me, I read your series history, found Bjorn comment a lot.

So I think Bjorn may have some comments for this.

Thanks!
Yijing.




-- 
Thanks!
Yijing
