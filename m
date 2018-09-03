From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 3 Sep 2018 11:34:29 +0100
Subject: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
In-Reply-To: <5B89F818.7060300@huawei.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-14-jean-philippe.brucker@arm.com>
 <5B83B11E.7010807@huawei.com> <1d5b6529-4e5a-723c-3f1b-dd5a9adb490c@arm.com>
 <5B89F818.7060300@huawei.com>
Message-ID: <3a961aff-e830-64bb-b6a9-14e08de1abf5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/18 03:23, Xu Zaibo wrote:
> As one application takes a whole function while using VFIO-PCI, why do 
> the application and the
> function need to enable PASID capability? (Since just one I/O page table 
> is enough for them.)

At the moment the series doesn't provide support for SVA without PASID
(on the I/O page fault path, 08/40). In addition the BIND ioctl could be
used by the owner application to bind other processes (slaves) and
perform sub-assignment. But that feature is incomplete because we don't
send stop_pasid notification to the owner when a slave dies.

Thanks,
Jean
