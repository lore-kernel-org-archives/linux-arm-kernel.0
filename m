From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 05 Aug 2013 10:01:06 -0600
Subject: [PATCH v2] ARM: DT: binding fixup to align with
 vendor-prefixes.txt
In-Reply-To: <1375482479-15732-1-git-send-email-csd@broadcom.com>
References: <1375482479-15732-1-git-send-email-csd@broadcom.com>
Message-ID: <51FFCC42.6040300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2013 04:27 PM, Christian Daudt wrote:
> [ this is a follow-up to this discussion:
> http://archive.arm.linux.org.uk/lurker/message/20130730.230827.a1ceb12a.en.html ]
> This patchset renames all uses of "bcm," name bindings to
> "brcm," as they were done prior to knowing that brcm had
> already been standardized as Broadcom vendor prefix
> (in Documentation/devicetree/bindings/vendor-prefixes.txt).
> This will not cause any churn on devices because none of
> these bindings have made it into production yet.
> Also rename the the following dt binding docs that had "bcm,"
> in their name for consistency:
>  - bcm,kona-sdhci.txt -> kona-sdhci.txt
>  - bcm,kona-timer.txt -> kona-timer.txt

> Changes since v1:
>  - added driver match table entries for deprecated names

That should usually go below the --- line so it doesn't make it into the
final patch description.

> diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt b/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
> index fb7b5cd..cf1b206 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
> +++ b/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt

I wonder if this patch should rename bindings/arm/bcm/ to
bindings/arm/brcm/ too?

>  Required root node property:
>  
> -compatible = "bcm,bcm11351";
> +compatible = "brcm,bcm11351";

In a patch of mine that deprecated a property, Mark wondered if it would
make sense to mention the old deprecated DT content simply to document
that it existed, so that old DTs would still make sense when checking
the documentation. I wonder if the same argument applies to this patch?
