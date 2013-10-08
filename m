From: tbergstrom@nvidia.com (=?ISO-8859-1?Q?Terje_Bergstr=F6m?=)
Date: Tue, 8 Oct 2013 11:20:07 +0300
Subject: [PATCH 1/2] clk: tegra114: Rename gr_2d/gr_3d to gr2d/gr3d
In-Reply-To: <20131008075356.GD3973@tbergstrom-lnx.Nvidia.com>
References: <1380748361-32459-1-git-send-email-treding@nvidia.com>
 <524EF436.4000704@wwwdotorg.org> <20131007001433.7445.7915@quantum>
 <20131007142839.GC3973@tbergstrom-lnx.Nvidia.com>
 <20131007145343.GA19045@ulmo.nvidia.com>
 <20131008075356.GD3973@tbergstrom-lnx.Nvidia.com>
Message-ID: <5253C037.8070105@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.10.2013 10:53, Peter De Schrijver wrote:
> On Mon, Oct 07, 2013 at 04:53:44PM +0200, Thierry Reding wrote:
>> What's wrong with pll_c? We've used it for Tegra20 and Tegra30 and I
>> have at least tested that gr2d works properly with it. It will also
>> cause both host1x and gr2d to run off the same clock, which I guess may
>> not matter at all.
> Using pll_c2 is consistent with our policy in downstream. It allows more
> freedom in scaling gr2d independently from host1x.

host1x really should be on a clock that is not scaled. This is because
it has some registers that need to be calibrated to the clock rate. It's
a pain to recalibrate whenever clock rate is modified. This is why
host1x is on PLLP downstream.

2D on the other hand (and all clients) is a prime candidate for clock
scaling.

This all is of course just hypothetical as long as we don't really scale
host1x' or its clients' clocks.

Terje
