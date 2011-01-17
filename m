From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jan 2011 13:01:29 +0000
Subject: [PATCH] Remove CPU_32v6K dependencies in asm/spinlock.h
In-Reply-To: <AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com>
References: <20110115161132.GH15996@n2100.arm.linux.org.uk>
	<AANLkTik8j2a9XXPQXw51Vbs=24hvP-PUJrVD--VNX0DG@mail.gmail.com>
Message-ID: <20110117130129.GB21542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 10:15:25AM +0000, Catalin Marinas wrote:
> In the SEV macro definition, can you also include the dsb? This
> barrier is only there because of sev, otherwise we don't need it (we
> have a dmb prior to releasing the lock).

I think until we have the whole SEV situation sorted out, it's best
to leave it as-is.

Leaving the dsb in there shouldn't cause a problem for a v6+v6k+v7
kernel, it just means we're wasting a few cycles stalling the
instruction pipeline while the dsb completes, which we don't really
need to do on v6.
