From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 13 Jan 2017 19:06:02 +0100
Subject: [PATCH 16/37] PCI: endpoint: Introduce configfs entry for
 configuring EP functions
In-Reply-To: <1484216786-17292-17-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-17-git-send-email-kishon@ti.com>
Message-ID: <20170113180602.GA30346@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

a couple comments on the configfs layout based on my experiments with
your previous drop to implement a NVMe device using it.

I don't think most of these configfs files should be present here, as
they are properties of the implemented PCIe devices.  E.g. for my
NVMe device they will be sort of hardcoded most of the time, as they
would be for other devices that would always have a fixed vendor/device/
class ID, cacheline size, etc.

In the end what we'll to be able to do here is to be able to create
a directory for each function driver, which then can create it's own
attributes inside it.
