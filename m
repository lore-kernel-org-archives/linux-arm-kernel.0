From: rric@kernel.org (Robert Richter)
Date: Wed, 24 Sep 2014 11:20:36 +0200
Subject: [PATCH v12 05/12] PCI: OF: Fix the conversion of IO ranges into
 IO resources.
In-Reply-To: <CAErSpo5GiycLfcx68tocfrGFt67+OPKLVZB1zdsZFU2M6gC_ag@mail.gmail.com>
References: <1411498874-9864-1-git-send-email-Liviu.Dudau@arm.com>
 <1411498874-9864-6-git-send-email-Liviu.Dudau@arm.com>
 <20140924002253.GB27357@google.com>
 <20140924011249.GC32643@bart.dudau.co.uk>
 <CAErSpo5GiycLfcx68tocfrGFt67+OPKLVZB1zdsZFU2M6gC_ag@mail.gmail.com>
Message-ID: <20140924092036.GC20256@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.09.14 19:16:19, Bjorn Helgaas wrote:
> You probably saw the subsequent [pci:pci/host-generic 10/13]
> drivers/of/of_pci.c:202:3: error: implicit declaration of function
> 'of_pci_range_to_resource' error.
> 
> I looked at that a bit, but gave up.  Apparently drivers/of/of_pci.c
> can be compiled with CONFIG_PCI=y but CONFIG_OF_ADDRESS not set..

This is due to the !SPARC dependency in drivers/of/Kconfig:

config OF_ADDRESS
        def_bool y
        depends on !SPARC
        select OF_ADDRESS_PCI if PCI

Error above occurs with ARCH=sparc.

-Robert
