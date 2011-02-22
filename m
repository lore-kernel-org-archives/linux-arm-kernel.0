From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Feb 2011 21:26:04 -0800
Subject: [PATCH 2/7] ARM: tegra: clock: Round rate before setting rate
In-Reply-To: <1298342392-21236-3-git-send-email-ccross@android.com>
References: <1298342392-21236-1-git-send-email-ccross@android.com>
	<1298342392-21236-3-git-send-email-ccross@android.com>
Message-ID: <AANLkTikV4++xA6JCh2yx_krdJrFddioZjBWe9pHP0b-x@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 6:39 PM, Colin Cross <ccross@android.com> wrote:
> Call the clock's round_rate op, if it exists, before calling
> the set_rate op. ?This will help later when dvfs is added,
> dvfs needs to know what the final rate will be before the
> frequency changes.
>
> Also requires fixes to the round rate functions to ensure
> calling round rate and then set rate will not cause the
> frequency to be rounded down twice. ?When picking clock
> divider values, the clock framework picks the closest
> frequency that is lower than the requested frequency. ?If
> the new frequency calculated from the divider value is
> rounded down, and then passed to set_rate, it will get
> rounded down again, possibly resulting in a frequency two
> steps lower than the original requested frequency.
>
> Fix the problem by rounding up when calculating the frequency
> coming out of a clock divider, so if that frequency is
> requested again, the same divider value will be picked.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Olof Johansson <olof@lixom.net>
