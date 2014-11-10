From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Nov 2014 14:38:45 -0700
Subject: serial: of-serial: fetch line number from DT
In-Reply-To: <CAOesGMjzs=dThDv6S8Xvo+ym-XECaQhTQ8NV6t46fQZ1LoJnHw@mail.gmail.com>
References: <CAOesGMjzs=dThDv6S8Xvo+ym-XECaQhTQ8NV6t46fQZ1LoJnHw@mail.gmail.com>
Message-ID: <54613065.1090300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2014 02:34 PM, Olof Johansson wrote:
> Greg,
>
> This commit:
>
> commit 1bd8324535ec1ff44aef55c0e40b9e7d56b310fb
> Author: Lucas Stach <dev@lynxeye.de>
> Date:   Mon Nov 3 23:16:54 2014 +0100
>
>      serial: of-serial: fetch line number from DT
...
> Broke a whole lot of tegra boards in last night's -next here. In
> particular, I've been looking at tegra20-seaboard, which now doesn't
> boot with console any more.
>
> http://arm-soc.lixom.net/bootlogs/next/next-20141110/
>
> Unfortunately, tegra has for a long time been specifying the aliases
> as a fixed 1:1 mapping, but most environments rely on ttyS0 being the
> first _activated_ serial port. That's obviously going to break things
> here. :(
...
> Stephen: I suppose the best way to handle this on tegra is to specify
> the aliases per-board instead of in the soc dtsi today.

IIRC, there was a deliberate request to name the Tegra UARTs after the 
SoC ports rather than board ports, so that it'd be obvious to people 
which port was which. I'm not sure if we can change the aliases in the 
Tegra DTs now that people may have got used to them?
