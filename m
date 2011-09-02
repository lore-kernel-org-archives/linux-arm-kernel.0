From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Sep 2011 10:11:48 +0200
Subject: [PATCH 2/4 v6] pinmux: add a driver for the U300 pinmux
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B327A40C@HQMAIL01.nvidia.com>
References: <1314869552-5531-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B327A40C@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdZ1kNbtOqw=X1mmM-bA+Gg2BbmO5_CT0sSQtBCK_WdwYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2011 at 11:33 PM, Stephen Warren <swarren@nvidia.com> wrote:

>> +static const struct u300_pmx_func u300_pmx_functions[] = {
>> + ? ? {
>> + ? ? ? ? ? ? .name = "power",
>> + ? ? ? ? ? ? .groups = { POWERGRP_INDEX },
>> + ? ? ? ? ? ? /* Mask is N/A */
>> + ? ? },
>
> Hmmm. That's a lot of _INDEX defines that'd need to be set up, at least
> to fully represent a chip like Tegra. Can the pinmux core be modified
> such that the group list is an array of names (char*) rather than the
> actual numeric IDs of the groups? Still, perhaps we could use the enum
> we already have for this, so perhaps it isn't a big deal...

Well I could think about a lot of ways to do this, but it's basically up
to the driver, the U300 is just some simple example of what you can
do, it's just trying to satisfy the API.

Maybe as part of writing the nVidia driver you find a clever
mechanism for doing this, if it's looking generally useful at that
point then let's move it to the core I'd say.

Thanks,
Linus Walleij
