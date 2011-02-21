From: ccross@android.com (Colin Cross)
Date: Sun, 20 Feb 2011 22:46:51 -0800
Subject: [PATCH v2 02/21] ARM: tegra: clock: Don't BUG on changing an
	enabled PLL
In-Reply-To: <AANLkTimk5boeykToWCrosa5Q+Di5_uiOEU8tqh-aa0SE@mail.gmail.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-4-git-send-email-ccross@android.com>
	<AANLkTimk5boeykToWCrosa5Q+Di5_uiOEU8tqh-aa0SE@mail.gmail.com>
Message-ID: <AANLkTim_y3cjWjHua0wc9pMvBNPMQNyamOyKgL92i3Vs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 8:06 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
>> Signed-off-by: Colin Cross <ccross@android.com>
>
> Please add a 1-line description of why bugging doesn't make sense.
>
> Patch itself:
>
> Acked-by: Olof Johansson <olof@lixom.net>
>

I will add:
When updating the CPU PLL frequency, keeping the PLL enabled avoids
ramping the PLL all the way down and back up again.  Remove the BUG_ON
in tegra2_pll_clk_set_rate to allow the rate to change while the PLL
is enabled.
