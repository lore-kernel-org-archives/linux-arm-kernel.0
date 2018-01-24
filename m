From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jan 2018 10:22:13 +0000
Subject: [PATCH RFC 0/3] API for 128-bit IO access
In-Reply-To: <20180124090519.6680-1-ynorov@caviumnetworks.com>
References: <20180124090519.6680-1-ynorov@caviumnetworks.com>
Message-ID: <20180124102212.GC20586@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 12:05:16PM +0300, Yury Norov wrote:
> This series adds API for 128-bit memory IO access and enables it for ARM64.
> The original motivation for 128-bit API came from new Cavium network device
> driver. The hardware requires 128-bit access to make things work. See
> description in patch 3 for details.
> 
> Also, starting from ARMv8.4, stp and ldp instructions become atomic, and
> API for 128-bit access would be helpful in core arm64 code.

Only for normal, cacheable memory, so they're not suitable for IO accesses
as you're proposing here.

Will
