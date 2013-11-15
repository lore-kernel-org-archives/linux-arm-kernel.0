From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Nov 2013 14:28:24 +0100
Subject: [PATCH v3 2/4] Documentation: Add documentation for APM X-Gene
 SATA controllor DTS binding
In-Reply-To: <1384465153-29902-3-git-send-email-lho@apm.com>
References: <1384465153-29902-1-git-send-email-lho@apm.com>
 <1384465153-29902-2-git-send-email-lho@apm.com>
 <1384465153-29902-3-git-send-email-lho@apm.com>
Message-ID: <201311151428.25204.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 November 2013, Loc Ho wrote:
> +Required properties:
> +- compatible           : Shall be "apm,xgene-ahci"
> +- reg                  : First memory resource shall be the AHCI memory
> +                         resource.
> +                         Second memory resource shall be the host controller
> +                         memory resource.
> +- id                   : Controller ID (0 = first, 1 = second, 2 = third)

As in the PHY patch, it's probably best to drop the "id" property here and
describe the actual differences between the instances directly, either by
having distinct "compatible" properties for each model, or by adding binary
flags to tell about a capability that only some instances have.

Also, I think you should have a separate file for the sata binding, especially
since the PHY binding is not actually specific to SATA at all.

Aside from these, the binding looks good to me now.

	Arnd
