From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 07:22:15 -0700
Subject: [PATCH V3] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <734c5d5a66ef8a5505f368fc68a8ab9c02d710f9.1492492253.git.viresh.kumar@linaro.org>
References: <734c5d5a66ef8a5505f368fc68a8ab9c02d710f9.1492492253.git.viresh.kumar@linaro.org>
Message-ID: <20170419142215.GA12105@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Tue, Apr 18, 2017 at 10:44:50AM +0530, Viresh Kumar wrote:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> (sunxi)
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com> (uniphier)
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Tony Lindgren <tony@atomide.com>

We've already turned down other patches that does this in a sweeping manner
like this, since they tend to be conflict prone with other DT changes.

Please split per platform and merge with each maintainer.


Thanks,

-Olof
