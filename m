From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Dec 2013 10:10:18 -0700
Subject: [PATCH v4 2/3] regulator: tps6586x: add and use correct voltage
 table
In-Reply-To: <127fe07e18665f93aa8d7c03e03164f1a049ddb6.1386108712.git.stefan@agner.ch>
References: <cover.1386108712.git.stefan@agner.ch>
 <127fe07e18665f93aa8d7c03e03164f1a049ddb6.1386108712.git.stefan@agner.ch>
Message-ID: <52A0B37A.2020900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 03:18 PM, Stefan Agner wrote:
> Depending on the regulator version, the voltage table might be 
> different. Use version specific regulator tables in order to
> select correct voltage table. For the following regulator versions
> different voltage tables are now used:
> 
> * TPS658623: Use correct voltage table for SM2 * TPS658643: New
> voltage table for SM2
> 
> Both versions are in use on the Colibri T20 module. Make use of
> the correct tables by requesting the correct SM2 voltage of 1.8V.
> 
> This change is not backward compatible since an old driver is not
> able to correctly set that value. The value 1.8V is out of range
> for the old driver and will refuse to probe the device. The
> regulator starts with default settings and the driver shows
> appropriate error messages.
> 
> On Colibri T20, the old value used to work with TPS658623 since
> the driver applied a wrong voltage table too. However, the
> TPS658643 used on V1.2 devices uses yet another voltage table and
> those broke that pseudo-compatibility. The regulator driver now has
> the correct voltage table for both regulator versions and those the
> correct voltage can be used in the device tree.

Acked-by: Stephen Warren <swarren@nvidia.com>
(yes, taking this through the MFD tree with patch 1/3 makes sense)
