From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 10 Aug 2011 14:20:08 +0530
Subject: [RFC PATCH 0/8] Introduce logical CPU mapping
In-Reply-To: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
References: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
Message-ID: <4E424640.6040801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Wednesday 10 August 2011 03:12 AM, Will Deacon wrote:
> Hello,
>
> This patch series is an RFC following a discussion I had with Russell
> the other day:
>
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060370.html
>
> The approach I've taken is fairly simple but is enough for booting on a
> CPU with physical ID != 0 on platforms which can handle it.
>
> Note that I haven't touched the OMAP4 or Tegra platforms since it's not
> clear from the code how they would be adapted to make use of the
> physical CPU number.
>
On OMAP, we use hardware register hand-shake for boot between a boot CPU
and non-boot CPU. On OMAP4, boot CPU has to be always CPU0 to ensure
that security and firewall initialisation is taken care. Other CPU can't
do those things.

Regards
Santosh
