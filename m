From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 14 Sep 2011 09:48:16 +0800
Subject: [PATCH 2/4 v6] pinmux: add a driver for the U300 pinmux
In-Reply-To: <CACRpkdan_g6dBvuXwbAdtHFd14GLkKsKLcHnybTuNGmYiqcStA@mail.gmail.com>
References: <1314869552-5531-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B327A40C@HQMAIL01.nvidia.com>
	<CACRpkdZ1kNbtOqw=X1mmM-bA+Gg2BbmO5_CT0sSQtBCK_WdwYw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B327A570@HQMAIL01.nvidia.com>
	<CACRpkdan_g6dBvuXwbAdtHFd14GLkKsKLcHnybTuNGmYiqcStA@mail.gmail.com>
Message-ID: <CAGsJ_4zRJaOs9W_jSXEGjAMNQhGTbDCPADc_uY7cvMpCEmKv9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/13 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Sep 2, 2011 at 6:04 PM, Stephen Warren <swarren@nvidia.com> wrote:
>> Linus Walleij wrote at Friday, September 02, 2011 2:12 AM:
>>> On Thu, Sep 1, 2011 at 11:33 PM, Stephen Warren <swarren@nvidia.com> wrote:
>>>
>>> >> +static const struct u300_pmx_func u300_pmx_functions[] = {
>>> >> + ? ? {
>>> >> + ? ? ? ? ? ? .name = "power",
>>> >> + ? ? ? ? ? ? .groups = { POWERGRP_INDEX },
>>> >> + ? ? ? ? ? ? /* Mask is N/A */
>>> >> + ? ? },
>>> >
>>> > Hmmm. That's a lot of _INDEX defines that'd need to be set up, at least
>>> > to fully represent a chip like Tegra. Can the pinmux core be modified
>>> > such that the group list is an array of names (char*) rather than the
>>> > actual numeric IDs of the groups? Still, perhaps we could use the enum
>>> > we already have for this, so perhaps it isn't a big deal...
>>>
>>> Well I could think about a lot of ways to do this, but it's basically up
>>> to the driver, the U300 is just some simple example of what you can
>>> do, it's just trying to satisfy the API.
>>>
>>> Maybe as part of writing the nVidia driver you find a clever
>>> mechanism for doing this, if it's looking generally useful at that
>>> point then let's move it to the core I'd say.
>>
>> The reason I asked about the pinmux core handling this is because the
>> driver op get_function_groups:
>>
>> + ? ? ? int (*get_function_groups) (struct pinctrl_dev *pctldev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned selector,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned ** const groups,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned * const num_groups);
>>
>> returns an array of integer indexes. I think the only way to get rid of
>> the index definitions in the drivers is to allow get_function_groups to
>> return an array of strings instead.
>
> OK good idea, I reworked this interface to get an array of strings
> instead, I've been told several times to use strings rather than numbers
> when possible, so I think this is the right thing to do.
>
> Check it out in v7!

well. we'll rebase prima2 pinmux on v7.

>
> Yours,
> Linus Walleij
>
-barry
