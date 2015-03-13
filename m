From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 12:05:20 +0100
Subject: [PATCH 2/2] Documentation: omap-twl4030: Remove ti, codec property
In-Reply-To: <1426194899-14037-3-git-send-email-marek@goldelico.com>
References: <1426194899-14037-1-git-send-email-marek@goldelico.com>
 <1426194899-14037-3-git-send-email-marek@goldelico.com>
Message-ID: <38159868.RLZZTyUOlK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 March 2015 22:14:59 Marek Belisko wrote:
> diff --git a/Documentation/devicetree/bindings/sound/omap-twl4030.txt b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
> index 1ab6bc8..656165f 100644
> --- a/Documentation/devicetree/bindings/sound/omap-twl4030.txt
> +++ b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
> @@ -4,7 +4,6 @@ Required properties:
>  - compatible: "ti,omap-twl4030"
>  - ti,model: Name of the sound card (for example "omap3beagle")
>  - ti,mcbsp: phandle for the McBSP node
> -- ti,codec: phandle for the twl4030 audio node

As this was a required property, are you sure that no other operating system
uses it?

Even if not, you should probably change it to be an optional property, so
that the existing dtbs do not become noncompliant after the change.

	Arnd
