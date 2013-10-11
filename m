From: davem@davemloft.net (David Miller)
Date: Fri, 11 Oct 2013 17:56:22 -0400 (EDT)
Subject: [PATCH 14/14] net: smc91x: dont't use SMC_outw for fixing up
 halfword-aligned data
In-Reply-To: <1381499540-28794-15-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
 <1381499540-28794-15-git-send-email-matthew.leach@arm.com>
Message-ID: <20131011.175622.988103254853137065.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Leach <matthew.leach@arm.com>
Date: Fri, 11 Oct 2013 14:52:20 +0100

> From: Will Deacon <will.deacon@arm.com>
> 
> SMC_outw invokes an endian-aware I/O accessor, which may change the data
> endianness before writing to the device. This is not suitable for data
> transfers where the memory buffer is simply a string of bytes that does
> not require any byte-swapping.
> 
> This patches fixes the smc91x SMC_PUSH_DATA macro so that it uses the
> string I/O accessor for outputting the leading or trailing halfwords on
> halfword-aligned buffers.
> 
> Cc: <netdev@vger.kernel.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Applied.
