From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Feb 2016 14:48:18 +0100
Subject: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host
 controller ECAM compliant
In-Reply-To: <1454935264-6076-3-git-send-email-gabriele.paoloni@huawei.com>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
 <1454935264-6076-3-git-send-email-gabriele.paoloni@huawei.com>
Message-ID: <3532826.pJr5R5Xa4c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 12:41:03 Gabriele Paoloni wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> This patch modifies the current Hip05/Hip06 PCIe host controller
> driver to make it ECAM compliant. This is needed in preparation
> for the ACPI based driver to allow both DT and ACPI drivers to
> use the same BIOS (that configure the Designware iATUs).
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> 

Doesn't this break backwards compatibility?

I think you need to use a new compatible string in the firmware
if you change the register layout, and then change the driver
to support both the old and the new layout.

	Arnd
