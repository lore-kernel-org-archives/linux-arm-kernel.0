From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 16 Nov 2011 17:55:06 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <20111116175050.GH2073@localhost.localdomain>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111116154402.GE2073@localhost.localdomain> <4EC3E446.4030608@gmail.com>
 <1321461458.3137.374.camel@hornet.cambridge.arm.com>
 <4EC3EBEC.3020601@gmail.com>
 <1321463271.3137.380.camel@hornet.cambridge.arm.com>
 <20111116173945.GG2073@localhost.localdomain>
 <20111116175050.GH2073@localhost.localdomain>
Message-ID: <1321466106.3137.397.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-16 at 17:50 +0000, Dave Martin wrote:
> Come to think of it, is the problem here that we're trying to describe
> the _motherboard_ using the compatible property on the root node.
> This is why I talked about universal/generic features -- the set of
> features common to all platforms sharing a single motherboard
> configuration.
> 
> Arguably that's wrong, and that compatible property belongs on the
> motherboard node itself, so (excuse the random syntax):
> 
> / {
> 	compatible = "arm,vexpress-v2p-ca9", "arm,vexpress";
> 
> 	motherboard {
> 		compatible = "arm,vexpress-v2m-legacy", "simple-bus";
> 	};
> };

> If putting a suitable compatible property on the motherboard node is
> feasible, it should work for this case.

Yep, that works for me :-) Probably even easier to implement than custom
property.

I'll get it into the code tomorrow.

Cheers!

Pawe?
