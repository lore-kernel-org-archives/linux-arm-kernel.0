From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 03 Jul 2014 20:04:51 +0200
Subject: [PATCH 2/2] mach-spear: fixed spear1340.c file
In-Reply-To: <1404354994-7478-1-git-send-email-xerofoify@gmail.com>
References: <1404354994-7478-1-git-send-email-xerofoify@gmail.com>
Message-ID: <1404410691.16291.11.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-02 at 22:36 -0400, Nicholas Krause wrote:
> This is the fixed file after moving sata support to new file in
> spear1340_sata.c
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/arm/mach-spear/spear1340.c | 111 ----------------------------------------
>  1 file changed, 111 deletions(-)

This patch, together with patch 1/2, basically moves a chunk of code
into a separate file, didn't it? If so, why did you split that move in
two patches?

And how does all this work without any changes to a Makefile?

> diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
> index 7b6bff7..f9d8ef3 100644
> --- a/arch/arm/mach-spear/spear1340.c
> +++ b/arch/arm/mach-spear/spear1340.c
> @@ -21,117 +21,6 @@
>  #include "generic.h"
>  #include <mach/spear.h>
>  
> -/* FIXME: Move SATA PHY code into a standalone driver */

(I have no idea what this FIXME is about, but I do wonder whether that
new file by itself is the standalone driver this FIXME is about. The
spear developers will surely know.)


Paul Bolle
