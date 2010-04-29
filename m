From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Apr 2010 17:20:35 +0100
Subject: Add support for the 16-way L310 L2 cache controller
Message-ID: <000701cae7b7$e61d45f0$b257d1d0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

The patch entitled `Add support for the 16-way L310 L2 cache controller'
which you submitted to RMK's patch system appears to perform a 16-way
invalidation even when the ways might not be present. This results in
writes to the reserved bits [15:8] of the invalidate-by-way ctrl register.

You can check the associativity by reading bit 16 of the auxiliary ctrl
register.

Will
