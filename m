From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 12:21:50 +0100
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <20140212103329.GC21992@e106331-lin.cambridge.arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <201402111508.06267.arnd@arndb.de>
 <20140212103329.GC21992@e106331-lin.cambridge.arm.com>
Message-ID: <201402121221.51233.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014, Mark Rutland wrote:
> To me it feels odd to require the last clock in the list (apb_pclk) to
> be named, and the rest to be in a particular order. For the dt case it
> seems saner to add new clocks with names as it allows arbitrary subsets
> of clocks to be wired up and described (though obviously in this case a
> missing sspclk would be problematic).

Yes, good point about the missing clocks, and I also agree mixing ordered
and named clocks in one device is rather odd and can lead to trouble.

I guess there isn't really a good way out here, and I certainly won't
ask for it to be done one way or the other if someone else has a 
good argument which way it should be implemented.

	Arnd
