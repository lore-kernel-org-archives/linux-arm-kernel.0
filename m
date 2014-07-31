From: cmetcalf@tilera.com (Chris Metcalf)
Date: Thu, 31 Jul 2014 16:24:37 -0400
Subject: [PATCH 2/5] char: tile-srom: Remove reference to platform_bus
In-Reply-To: <1406298233-27876-2-git-send-email-pawel.moll@arm.com>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-2-git-send-email-pawel.moll@arm.com>
Message-ID: <53DAA605.2030500@tilera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/25/2014 10:23 AM, Pawel Moll wrote:
> The code was creating "srom" class devices using
> platform_bus as a parent. As they are not really
> platform devices, make them virtual, using NULL instead.
>
> Cc: Chris Metcalf<cmetcalf@tilera.com>
> Signed-off-by: Pawel Moll<pawel.moll@arm.com>
> ---
>   drivers/char/tile-srom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Can you clarify the point of this change a bit?  The SROM devices
in question are real devices (bits of silicon on the processor die), not
some kind of virtual construct.  In addition, we also have user binaries
in the wild that know to look for /sys/devices/platform/srom/ paths,
so I'm pretty reluctant to change this path without good reason.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
