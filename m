From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Sep 2011 10:02:38 +0100
Subject: [RFC PATCH 10/11] regulator: Implement consumer regulator
	mapping from device tree
In-Reply-To: <4E72F8E2.3020200@ti.com>
References: <1316085727-15023-4-git-send-email-rnayak@ti.com>
	<1316085727-15023-5-git-send-email-rnayak@ti.com>
	<1316085727-15023-6-git-send-email-rnayak@ti.com>
	<1316085727-15023-7-git-send-email-rnayak@ti.com>
	<1316085727-15023-8-git-send-email-rnayak@ti.com>
	<1316085727-15023-9-git-send-email-rnayak@ti.com>
	<1316085727-15023-10-git-send-email-rnayak@ti.com>
	<1316085727-15023-11-git-send-email-rnayak@ti.com>
	<20110915135939.GO7988@opensource.wolfsonmicro.com>
	<4E72F8E2.3020200@ti.com>
Message-ID: <20110916090238.GF22062@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 12:51:06PM +0530, Rajendra Nayak wrote:
> On Thursday 15 September 2011 07:29 PM, Mark Brown wrote:

> >This seems wrong, why are we adding things to the regulator_map which is
> >really only there for lookups when we already did the lookup using the
> >device tree?

> I did this only so the mappings show up in sysfs.

Reworking to bind sysfs at regulator_get() time seems a better approach
to this.
