From: robh@kernel.org (Rob Herring)
Date: Wed, 4 Jan 2017 08:57:32 -0600
Subject: [PATCH] mailbox: sti: Fix mbox-names copy and paste error
In-Reply-To: <20170104120527.24806-1-lee.jones@linaro.org>
References: <20170104120527.24806-1-lee.jones@linaro.org>
Message-ID: <20170104145732.7yiqbi7rf7m6lem4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 12:05:27PM +0000, Lee Jones wrote:
> Due to an over-sight, mbox-names has become mbox-name in some instances.
> 
> Let's put it right.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/mailbox/sti-mailbox.txt | 4 ++--
>  arch/arm/boot/dts/stih407-family.dtsi                     | 8 ++++----
>  drivers/mailbox/mailbox-sti.c                             | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> index 351f612..648d176 100644
> --- a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> +++ b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> @@ -9,7 +9,7 @@ Controller
>  Required properties:
>  - compatible		: Should be "st,stih407-mailbox"
>  - reg			: Offset and length of the device's register set
> -- mbox-name		: Name of the mailbox
> +- mbox-names		: Name of the mailbox

It's worse than this. mbox-names is for the mailbox client side. This 
should just be dropped. Plus, *-names is pointless when there is only 1 
element.

Rob
