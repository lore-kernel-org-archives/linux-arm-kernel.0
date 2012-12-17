From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 17 Dec 2012 08:31:35 +0000
Subject: Warnings from u9500 device trees
In-Reply-To: <CAOesGMhwht8oRMAT=9Kh2hLmOZEZ=n_QVoNVB=Q4qZFj1HyU2Q@mail.gmail.com>
References: <CAOesGMhwht8oRMAT=9Kh2hLmOZEZ=n_QVoNVB=Q4qZFj1HyU2Q@mail.gmail.com>
Message-ID: <20121217083135.GU27617@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

> Known issue? I haven't seen a patch for it on the lists yet.
> 
> Warning (reg_format): "reg" property in
> /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes)
> (#address-cells == 1, #size-cells == 1)
> Warning (reg_format): "reg" property in
> /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes)
> (#address-cells == 1, #size-cells == 1)
> Warning (reg_format): "reg" property in
> /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes)
> (#address-cells == 1, #size-cells == 1)
> Warning (reg_format): "reg" property in
> /soc-u9500/prcmu at 80157000/ab8500 at 5 has invalid length (4 bytes)
> (#address-cells == 1, #size-cells == 1)
> 
> 
> prcmu has #address-cells of 1, and #size-cells of 1, but the reg is
> just a single cell on that entry (<5>). Something's weird with either
> the binding you've implemented, or how you specified the device tree.
> 
> The changes are old too, since March. No one else has noticed this
> since then? Are there no users of this platform? :(

Neither. We've known about it since March (including Arnd), but it's
not important. The issue is that #size-cells can't be 0, but the 
AB8500 uses mailboxes not registers, so there is no size per-say. I
have requested that we remove the 'reg' property entirely, as the
Mailbox number is hard-coded, but Arnd wasn't a fan, so we just left
it as-is.

Out of interest, why are you getting 4 errors? Are you building all
of the DTS:es at once?

Kind regards,
Lee

> commit 7e0ce270b2ef3d0d00c3f0725f48aa3127d73edf
> Author:     Lee Jones <lee.jones@linaro.org>
> AuthorDate: Thu Mar 15 16:46:17 2012 +0000
> Commit:     Arnd Bergmann <arnd@arndb.de>
> CommitDate: Fri Mar 16 19:46:13 2012 +0000
> 
>     ARM: ux500: db8500: list most devices in the snowball device tree
> 
> 
> -Olof

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
