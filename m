From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 21 Aug 2014 16:44:31 +0300
Subject: [PATCH 0/2] clk: ti: Fix up error checks in set_rate (and div
 0 error)
In-Reply-To: <1408381015-16042-1-git-send-email-nm@ti.com>
References: <1408381015-16042-1-git-send-email-nm@ti.com>
Message-ID: <53F5F7BF.6040809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2014 07:56 PM, Nishanth Menon wrote:
> Hi,
> The following patches are based on v3.17-rc1
> Prior to this series: http://slexy.org/view/s20QH6PW4x (notice the /0 div error spam at initial boot log)
> After this series: http://slexy.org/view/s20tPNXPf4

Yeah, valid findings. However, you did not root-cause the problem, just 
added a bandaid for the most obvious errors. I will queue these patches 
for 3.17-rc fixes anyway, but will post an actual fix in a bit.

-Tero

>
> Nishanth Menon (2):
>    clk: ti: divider: Provide error check for incoming parameters in
>      set_rate
>    clk: ti: dra7-atl: Provide error check for incoming parameters in
>      set_rate
>
>   drivers/clk/ti/clk-dra7-atl.c |    6 +++++-
>   drivers/clk/ti/divider.c      |    7 ++++++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
>
