From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 10 Apr 2017 08:11:24 +0200
Subject: [PATCH] PM / OPP: Use - instead of @ for DT entries
In-Reply-To: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
References: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
Message-ID: <CAJKOXPcrgW4U+j9WGsXnfX8J7df3Gy-Drfvy7nZHCVbQ0Ddf7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 7:16 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Compiling the DT file with W=1, DTC warns like follows:
>
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
> unit name, but no reg property
>
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.
>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This is an very old issue:
https://www.spinics.net/lists/devicetree/msg120914.html
(reported year ago, please update the Reported-by)
and guide was to either use oppN format or whitelist opp nodes in dtc.
Apparently the second never happened...

Best regards,
Krzysztof
