From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Feb 2015 11:26:23 +0000
Subject: GICv3: Support for active low level-sensitive PPIs in
 device-tree binding
In-Reply-To: <BY1PR0301MB1303EF578091444B2C5CA3AD82150@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <BY1PR0301MB1303EF578091444B2C5CA3AD82150@BY1PR0301MB1303.namprd03.prod.outlook.com>
Message-ID: <20150227112623.57915b1f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Feb 2015 11:13:08 +0000
"bhupesh.sharma at freescale.com" <bhupesh.sharma@freescale.com> wrote:

> Hi,
> 
> While the GICv2 device-tree binding document (see [1]) seems to have
> support for active low level-sensitive PPIs:
> 
> The 3rd cell is the flags, encoded as follows:
> 	bits[3:0] trigger type and level flags.
> 		1 = low-to-high edge triggered
> 		2 = high-to-low edge triggered (invalid for SPIs)
> 		4 = active high level-sensitive
> 		8 = active low level-sensitive (invalid for SPIs).
> 
> The GICv3 device-tree bindings (see [2]) on the other hand, seem to
> be lacking the same for active low level-sensitive PPIs:
> 
>   The 3rd cell is the flags, encoded as follows:
> 	bits[3:0] trigger type and level flags.
> 		1 = edge triggered
> 		4 = level triggered
> 
> One of our SoC, supports active low level-sensitive PPIs on GICv3. If
> I spin-out a patch to address the same in GICv3 bindings, will that
> be acceptable, or, is something on similar lines already in-work.

Yes, please send in a patch (possible saying "valid for PPIs only"
instead of "invalid for SPIs", so that we don't have to restrict it
for LPIs either).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny.
