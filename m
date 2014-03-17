From: olof@lixom.net (Olof Johansson)
Date: Mon, 17 Mar 2014 00:46:11 -0700
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC DT Updates for
 v3.15
In-Reply-To: <cover.1394080829.git.horms+renesas@verge.net.au>
References: <cover.1394080829.git.horms+renesas@verge.net.au>
Message-ID: <20140317074611.GH21917@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 01:44:28PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider this fourth round of Renesas ARM based SoC DT updates for v3.15.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-dt3-for-v3.15,
> which I have already sent a pull-request for.
> 
> 
> The following changes since commit 367aaaea1d6c6496695ffd06b49590b8cfcb8aa5:
> 
>   ARM: shmobile: genmai: adapt dts to use native i2c driver (2014-02-18 11:35:30 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt4-for-v3.15

Hi,

I've merged this into next/dt. However, a general comment on these patches:

> Sergei Shtylyov (4):
>       ARM: shmobile: r8a7790: add Ether DT support
>       ARM: shmobile: lager: add Ether DT support
>       ARM: shmobile: r8a7791: add Ether DT support
>       ARM: shmobile: koelsch: add Ether DT support

I think you should consider doing a generic binding for the ethernet
controller, that specifies the data that the driver needs as part of the device
tree contents. that way you don't have to add a new _data structure for every
new SoC that implements things -- from taking a brief look at the driver there
seems to be a bit of boiler plate and/or several parts that share common
feature sets already.

Anyway, given the way the binding is written, this can be done later by adding
a generic compatible string that expects more properties, etc -- so it's not
something that needs to be done now. But I do recommend that as you add new
SoCs in the future (if you do).


-Olof
