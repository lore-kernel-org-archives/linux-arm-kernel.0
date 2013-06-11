From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Jun 2013 16:48:39 +0900
Subject: [PATCH v2 2/2] ARM: shmobile: r8a7779: fix Ether device name
In-Reply-To: <201306090124.35464.sergei.shtylyov@cogentembedded.com>
References: <201306090124.35464.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130611074839.GD10440@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 09, 2013 at 01:24:35AM +0400, Sergei Shtylyov wrote:
> While recasting commit dace48d04dee46a3409d5e13cd98031522e46377 (ARM: shmobile:
> R8A7779: add Ether support), I made a typo in the platform device's name: used
> underscore instead of hyphen.
> 
> However, there's now patch merged to net-next.git renaming the platform device
> from "sh-eth" to "r8a777x-ehter", so it makes the most sense to change the name
> straight to that one.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is atop of the 'renesas-next-20130607' tag of the 'renesas.git' tree
> and the USB patches I have submitted earlier.
> 
> Changes in version 2:
> - changed the platform device's name as in the patch merged to 'net-next.git';
> - lowercased the SoC name in the subject.
> 
>  arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I have queued this up in the soc2 branch.
My current plan is to let that branch sit in next for a few
days and then send a pull-request for it to be included in v3.11.
