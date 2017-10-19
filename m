From: jeffy.chen@rock-chips.com (jeffy)
Date: Thu, 19 Oct 2017 19:19:57 +0800
Subject: [PATCH v6 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <20171018132936.GP5641@bhelgaas-glaptop.roam.corp.google.com>
References: <20171013195059.23865-1-jeffy.chen@rock-chips.com>
 <20171013195059.23865-2-jeffy.chen@rock-chips.com>
 <20171016200350.GH25517@bhelgaas-glaptop.roam.corp.google.com>
 <20171018010312.GB65743@google.com>
 <20171018132936.GP5641@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <59E88A5D.8060309@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 10/18/2017 09:29 PM, Bjorn Helgaas wrote:
>> >
>> >I guess it could work to look into pci_create_root_bus(), and
>> >do something like the following?
>> >
>> >	if (IS_ENABLED(CONFIG_OF) && parent && parent->of_node)
>> >		... do OF parsing for generic features like WAKE# ...
> That's exactly the sort of thing I was thinking.
>
i was looking at that too, but i'm not very clear about how to handle 
the platform_ops's set_wakeup...
