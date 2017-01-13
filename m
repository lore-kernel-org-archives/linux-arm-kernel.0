From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jan 2017 11:48:01 +0000
Subject: [PATCH] arm64: defconfig: disable CONFIG_DEVMEM
In-Reply-To: <20170113113734.16524-1-leif.lindholm@linaro.org>
References: <20170113113734.16524-1-leif.lindholm@linaro.org>
Message-ID: <20170113114801.GD3253@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 11:37:34AM +0000, Leif Lindholm wrote:
> /dev/mem is the opposite of what an operating system is for.
> Additionally, on arm* it opens up for denial-of-service attacks from
> userspace. So leave it disabled by default, requiring people who need
> it to enable it explicitly.

I really like the idea, but are we sure that nothing common breaks without
this? For example, does Debian still boot nicely with this patch applied?

Just trying to get a feel for how much userspace this has seen (particularly
on ACPI-based systems, which I seem to remember like poking about in here).

Will
