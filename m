From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 18 May 2011 10:47:18 +0100
Subject: [PATCH] arm: Add Cortex A5 proc_info
In-Reply-To: <1305650956-20997-1-git-send-email-pawel.moll@arm.com>
References: <1305650956-20997-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1305712038.17656.41.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	.long	0x410fc050		@ Required ID value
> +	.long	0xff0ffff0		@ Mask for ID

Alternatively I could "reuse" current A9 proc_info and change ID value
and mask to:

0x410fc010
0xff0fff30

This would:

* match Cortex A5 (part no. 0xc05) and A9 (0xc09)

* not match A8 (0xc08) and A15 (0xc0f)

Everything is fine so far, but also:

* match part no. 0xc01 and 0xc0d

Obviously no parts like that exist today, but somehow this "solution"
doesn't appeal to me... Of course it would save 39 lines in diff
stat ;-)

Any thoughts?

Pawe?
