From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 Apr 2015 19:30:46 -0600
Subject: [PATCH 1/3 v5] dt/bindings: Add binding for the BCM2835 mailbox
 driver
In-Reply-To: <1430253868-11138-1-git-send-email-eric@anholt.net>
References: <1430173644-19099-2-git-send-email-eric@anholt.net>
 <1430253868-11138-1-git-send-email-eric@anholt.net>
Message-ID: <55403446.1040207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2015 02:44 PM, Eric Anholt wrote:
> From: Lubomir Rintel <lkundrak@v3.sk>
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> 
> v2: Split into a separate patch for submitting to the devicetree list.
>     Consistently start node docs with a capital letter. device's
>     address in the example shouldn't have "0x". Drop machine-specific
>     interrupt numbers from the docs.  (changes by anholt).
> 
> v3: Move the file to just bcm2835-mbox.txt, clean up formatting
>     (changes by anholt, from review by Lee Jones).
> 
> v4: Move file back by consensus from various Broadcom platform
>     maintainers (changes by anholt, acked by Lee Jones).
> 
> v5: Document that the mailbox cell should be 0 in clients, and add an
>     example of a client (changes by anholt, from review by Jassi).

Some mention of what you changed in the patch might be nice, since it
was originally authored by someone else, and there's quite a changelog.

> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt

> +- #mbox-cells:	Specifies the number of cells needed to encode a mailbox
> +		  channel. The value shall be 1.  Clients should supply a value
> +		  of 0 for the mailbox channel, because there is only one
> +		  exposed

Can't you use #mbox-cells = <0> if there's no data to provide?
