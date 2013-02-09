From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Feb 2013 12:09:12 +0000
Subject: [PATCH 13/17] ARM: pl01x debug code endian fix
In-Reply-To: <1360365467-25056-14-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-14-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130209120912.GG17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 11:17:43PM +0000, Ben Dooks wrote:
> +#ifdef __ARMEB__
> +#define ARM_BE(x...) x
> +#else
> +#define ARM_BE(x..)

Buggy.

> +#endif

Rather than littering the code with stuff like this, define it in one
central place please, and include it where necessary.
