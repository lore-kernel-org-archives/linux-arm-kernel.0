From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:28:11 -0800
Subject: [PATCH v2 20/21] ARM: tegra: clock: Fix clock issues in suspend
In-Reply-To: <1298154371-5641-22-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-22-git-send-email-ccross@android.com>
Message-ID: <AANLkTin-=rv8HoUhUYJbfrsXHHE7iysqdC+W97C-_bM=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:26 PM, Colin Cross <ccross@android.com> wrote:
> The PLLP registers are now being restored by the low-level resume code,
> and the CPU may be running off PLLP, so don't touch them during clock
> resume.
>
> Save plld, plls, pllu, and audio clock during suspend (originally
> fixed by Mayuresh Kulkarni <mkulkarni@nvidia.com>)
>
> The lock time for plld is 1000 us, so increase the delay after
> setting the PLLs.
>
> Add a BUG_ON to ensure the size of the suspend context area is
> correct.

It's a bummer that this can't be done (easily) at build time, it'd be
more useful. Oh well, still good to catch at runtime at least.


> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
