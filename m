From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 8 Feb 2017 23:19:56 -0800
Subject: [PATCH v1 1/3] PCI: xilinx: Configure PCIe MPS settings
In-Reply-To: <20170208224930.14351.91597.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170208224930.14351.91597.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170209071956.GA21656@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 04:49:30PM -0600, Bjorn Helgaas wrote:
> +	list_for_each_entry(child, &bus->children, node)
> +		pcie_bus_configure_settings(child);

This loop is duplicated in just about every driver, so it it
might be a good idea to provide a littler helper for it.
