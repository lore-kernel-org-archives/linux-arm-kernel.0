From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Tue, 24 Oct 2017 15:31:54 +0100
Subject: [PATCH v3 0/2] arm: remove cpu_efficiency
In-Reply-To: <20171024105227.GD20805@n2100.armlinux.org.uk>
References: <20171024102718.16113-1-dietmar.eggemann@arm.com>
 <20171024105227.GD20805@n2100.armlinux.org.uk>
Message-ID: <316592bf-5aa4-3847-79cd-3a26adbb1231@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

Thanks for the review!

On 24/10/17 11:52, Russell King - ARM Linux wrote:
> On Tue, Oct 24, 2017 at 11:27:16AM +0100, Dietmar Eggemann wrote:
>> With the dt related patches for exynos and renesas now in the
>> appropriated for-next branches for v4.15 there are no Cortex-A15/A7 arm
>> big.LITTLE systems left relying on the 'cpu_efficiency/clock-frequency
>> dt property' based solution anymore.
> 
> This is way too early to remove support for something that has been
> in place since 2012.  As you've just shown, people are using it with
> DT files today.  We don't know how long people will persist using
> older files, and we don't know whether there are DT files out in the
> wild that we don't know about.

Understood. But do we really care about out of tree dt files?

In case the mentioned exynos and renesas Cortex-A15/A7 platforms change
to using 'capacity-dmips-mhz' in v4.15 there shouldn't be any
Cortex-A15/A7 platforms in mainline left using the cpu_efficiency
solution anymore.

> Our general rule is that we maintain compatibility for older DT.

OK.

> NAK.

Then I still send out [2/2] separately.
