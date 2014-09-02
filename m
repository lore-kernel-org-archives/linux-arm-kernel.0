From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Sep 2014 17:08:29 +0200
Subject: [RFC PATCH 4/7] iommu: provide helper function to configure an
 IOMMU for an of master
In-Reply-To: <b8484a1ea45846bbaa8512d4597b9e65@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <3424322.yoZKhlAsy0@wuerfel>
 <b8484a1ea45846bbaa8512d4597b9e65@BL2PR03MB468.namprd03.prod.outlook.com>
Message-ID: <2801290.H6TrhuIyTE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 15:03:14 Varun Sethi wrote:
> Hi Thierry/Will/Arnd,
> Where would the of_xlate callback reside and what would be its function? 
> 

It is an additional function pointer in iommu_ops and replaces the
add_device callback for IOMMUs that are DT-enabled.

The idea is that we can have a single function that sets up DMA
for the device properly, including iommus when they are configured,
and it lets us pass the necessary parameters describing the setup
of the master device into the iommu driver.

	Arnd
