From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 22:13:54 +0100
Subject: [PATCH 1/2] PCI: iproc: fix 32-bit build
In-Reply-To: <e03e5c52-f321-916e-4650-c8bb271cd041@broadcom.com>
References: <20161122141844.1655574-1-arnd@arndb.de>
 <e03e5c52-f321-916e-4650-c8bb271cd041@broadcom.com>
Message-ID: <4393833.rTFctaL9Kd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 9:42:05 AM CET Ray Jui wrote:
> 
> Hmmm, somehow we've never seen this link error for the ARM32 based
> platforms that we build for. Does it behave differently between
> different versions of compilers?
> 
> Nevertheless, this is a good change to take, thanks!

I looked at it again, and see now that it only happens with
a 64-bit RESOURCE_SIZE_T, which is only used on 32-bit
platforms with more than 4GB of memory addresses. It would
however show up in a multiplatform distro build for ARMv7VE,
so the fix is still clearly needed.

	Arnd
