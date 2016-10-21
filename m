From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Oct 2016 10:52:23 +0800
Subject: [PATCH v2] mmc: sunxi: Prevent against null dereference for vmmc
In-Reply-To: <20161019133304.22915-1-maxime.ripard@free-electrons.com>
References: <20161019133304.22915-1-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67L8MZuLYLUpiG-afOdEXTw4DtJtR7VdPUabwTNejsPmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 9:33 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> VMMC is an optional regulator, which means that mmc_regulator_get_supply
> will only return an error in case of a deferred probe, but not when the
> regulator is not set in the DT.
>
> However, the sunxi driver assumes that VMMC is always there, and doesn't
> check the value of the regulator pointer before using it, which obviously
> leads to a (close to) null pointer dereference.
>
> Add proper checks to prevent that.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
