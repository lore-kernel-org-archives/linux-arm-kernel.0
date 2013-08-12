From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Aug 2013 15:14:07 -0400
Subject: [PATCH 15/16] arch/arm/mach-kirkwood: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376239917-15594-16-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376239917-15594-16-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20130812191407.GS25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 06:51:56PM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
> arity of the called function.
> 
> The semantic match that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e,f;
> @@
> 
> f(...,
> - ARRAY_AND_SIZE(e)
> + e,ARRAY_SIZE(e)
>   ,...)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
> Not compiled.

compiled fine on arm.

>  arch/arm/mach-kirkwood/openrd-setup.c    |    3 ++-
>  arch/arm/mach-kirkwood/rd88f6281-setup.c |    4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Applied to mvebu/boards

thx,

Jason.
