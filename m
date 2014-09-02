From: jroedel@suse.de (jroedel at suse.de)
Date: Tue, 2 Sep 2014 22:59:41 +0200
Subject: [RFC PATCH 4/7] iommu: provide helper function to configure an
 IOMMU for an of master
In-Reply-To: <5897964.3ztXLVfPDF@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <3424322.yoZKhlAsy0@wuerfel> <20140902130508.GK25379@arm.com>
 <5897964.3ztXLVfPDF@wuerfel>
Message-ID: <20140902205941.GA26123@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 04:01:32PM +0200, Arnd Bergmann wrote:
> This is an artifact of the API being single-instance at the moment.
> We might not in fact need it, I was just trying to think of things
> that naturally fit in there and that are probably already linked
> together in the individual iommu drivers.

I am not sure what you mean by single-instance. Is it that currently the
API only supports one type of iommu_ops per bus? That should be fine as
long as there is only one type of IOMMU on the bus.

Besides that, it is a feature of the IOMMU-API to hide the details about
all the hardware IOMMUs in the system from its users.


	Joerg
