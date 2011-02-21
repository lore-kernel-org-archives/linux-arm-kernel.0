From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 20:23:20 -0800
Subject: [PATCH v2 18/21] ARM: tegra: cpufreq: Adjust memory frequency
	with cpu frequency
In-Reply-To: <1298154371-5641-20-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-20-git-send-email-ccross@android.com>
Message-ID: <AANLkTikbOQZ2jW+mfN41dXwuKVVJ3vCVKRZLezxbj61o@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 2:26 PM, Colin Cross <ccross@android.com> wrote:
> Signed-off-by: Colin Cross <ccross@android.com>

Patch description please. Besides that:

Acked-by: Olof Johansson <olof@lixom.net>

But note for future work:


> + ? ? ? /*
> + ? ? ? ?* Vote on memory bus frequency based on cpu frequency
> + ? ? ? ?* This sets the minimum frequency, display or avp may request higher
> + ? ? ? ?*/
> + ? ? ? if (rate >= 816000)
> + ? ? ? ? ? ? ? clk_set_rate(emc_clk, 600000000); /* cpu 816 MHz, emc max */
> + ? ? ? else if (rate >= 456000)
> + ? ? ? ? ? ? ? clk_set_rate(emc_clk, 300000000); /* cpu 456 MHz, emc 150Mhz */
> + ? ? ? else
> + ? ? ? ? ? ? ? clk_set_rate(emc_clk, 100000000); ?/* emc 50Mhz */
> +


This hardcodes frequencies that might or might not be used on some
systems and some parts. So it'll need to be revisited when enabling
other configurations.


-Olof
