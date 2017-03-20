From: robert.richter@cavium.com (Robert Richter)
Date: Mon, 20 Mar 2017 12:02:41 +0100
Subject: [PATCH 2/2] PCI: Add legacy firmware support for Cavium ThunderX
 host controller
In-Reply-To: <1489564155-3881-3-git-send-email-tn@semihalf.com>
References: <1489564155-3881-1-git-send-email-tn@semihalf.com>
 <1489564155-3881-3-git-send-email-tn@semihalf.com>
Message-ID: <20170320110241.GG16822@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.03.17 08:49:15, Tomasz Nowicki wrote:
> During early days of PCI quirks support ThunderX firmware did not provide
> PNP0c02 node with PCI configuration space and PEM-specific register ranges.
> This means that for legacy FW we are not reserving these resources and
> cannot gather PEM-specific resources for further PEM initialization.
> 
> In order to support already deployed legacy FW calculate PEM-specific ranges
> and provide resources reservation as fallback scenario into PEM driver when
> we could not gather PEM reg base from ACPI tables.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>

Works with old and new firmware.

Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>

-Robert
