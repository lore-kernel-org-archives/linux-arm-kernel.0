From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 May 2017 09:56:16 +0100
Subject: [PATCH 0/2] ioremap_wc on arm64
In-Reply-To: <1495436507-81890-1-git-send-email-jnair@caviumnetworks.com>
References: <1495436507-81890-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <20170522085615.GC30129@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 07:01:45AM +0000, Jayachandran C wrote:
> From its definition, the device "gather" attribute seems to be a better
> fit for implementing write combining mapping in ioremap_wc().  And on
> ThunderX2, Device GRE mapping has optimizations that makes it much faster
> than normal uncached mapping.
> 
> I am not sure of the reasoning behind the original decision to make
> ioremap_wc use "Normal Non-Cached" attribute, since all the other variants
> of ioremap use device attributes, and ioremap_wc looks like an exception.

The reason we kept it as Normal NC is that Device_GRE does not allow
unaligned accesses.

-- 
Catalin
