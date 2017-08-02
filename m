From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 14:25:50 +0200
Subject: [PATCH] pinctrl: sirf: atlas7: Initialize GPIO offset
In-Reply-To: <20170720170107.14612-1-thierry.reding@gmail.com>
References: <20170720170107.14612-1-thierry.reding@gmail.com>
Message-ID: <CACRpkdZjncCq_D-QVG7gEx8cVusEzyjeYhcgc=wLtGREA40x=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 7:01 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> The GPIO offset is never initialized, which means that it will end up
> being zero as per the devm_kzalloc() of the parent structure.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> I have no idea how the driver could've ever worked for anything other
> than instances with a single bank, but maybe it did and I missed some
> detail.

Patch applied.

I went in and attack-patched this driver, see:
commit 4e6fd26dcf5d70a7700a4c15d8f239103bdce91d
"pinctrl: sirf/atlas7: stop poking around in GPIO internals"

I don't know if I may have upset the SirF developers or something,
or if I was an especially big asshole for not noticing the problem I
fixed already in the first iteration of the patch, or if I have done something
else evil, but I just haven't heard from the developers since.

If the problem is me, I'm sorry :(

I would like to have this driver up-to-date and verified working.

Yours,
Linus Walleij
