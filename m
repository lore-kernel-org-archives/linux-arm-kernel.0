From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 10 Nov 2016 10:58:06 +0000
Subject: [PATCH v7 00/16] ACPI IORT ARM SMMU support
In-Reply-To: <CAJZ5v0j09fsp4Y66v2UANOGnW4FNO7PWxpZY=Pgw=bUccEL_eA@mail.gmail.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <CAJZ5v0j09fsp4Y66v2UANOGnW4FNO7PWxpZY=Pgw=bUccEL_eA@mail.gmail.com>
Message-ID: <20161110105806.GA20209@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Thu, Nov 10, 2016 at 12:36:12AM +0100, Rafael J. Wysocki wrote:
> Hi Lorenzo,
> 
> On Wed, Nov 9, 2016 at 3:19 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > This patch series is v7 of a previous posting:
> >
> > https://lkml.org/lkml/2016/10/18/506
> 
> I don't see anything objectionable in this series.

Thank you very much !

> Please let me know which patches in particular to look at in detail.

Apart from patch 1, patch 7 (and patch 16 that adds on top of it)
requires an ack from an ACPI core perspective. acpi_dma_configure()
should not affect x86/ia64 systems at all so those patches should
not really be controversial (patch 16 adds an IORT hook into
acpi_dma_configure() that is a nop by design on anything other than
ARM64), please let me know if they are ok.

Thank you again for your time,
Lorenzo
