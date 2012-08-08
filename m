From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Aug 2012 16:19:47 +0100
Subject: [RFC 3/6] arm: cache-l2x0: add support for Aurora L2 cache ctrl
In-Reply-To: <1344438307-8468-4-git-send-email-gregory.clement@free-electrons.com>
References: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
 <1344438307-8468-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120808151946.GE4579@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 04:05:03PM +0100, Gregory CLEMENT wrote:
> +static void aurora_pa_range(unsigned long start, unsigned long end,
> +                       unsigned long offset)
> +{

This controller is used by Armada XP right? I think that SoC supports LPAE,
so please tell me that the above is a mistake and the controller can support
physical addresses > 32 bits!

If so, you'll need to hack the cache-l2x0 driver to use phys_addr_t types
instead of unsigned longs.

Will
