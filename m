From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Jun 2014 22:32:30 +0200
Subject: [PATCHv2 2/2] ARM: tegra: tamonten: add the display to the
 Medcom Wide
In-Reply-To: <1403184350-25403-2-git-send-email-alban.bedel@avionic-design.de>
References: <1403184350-25403-1-git-send-email-alban.bedel@avionic-design.de>
 <1403184350-25403-2-git-send-email-alban.bedel@avionic-design.de>
Message-ID: <20140620203229.GB28814@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 03:25:50PM +0200, Alban Bedel wrote:
[...]
> diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
[...]
> @@ -38,6 +47,15 @@
>  		default-brightness-level = <6>;
>  	};
>  
> +	panel: panel {
> +		compatible = "innolux,n156bge-l21", "simple-panel";
> +
> +		power-supply =  <&vdd_1v8_reg>, <&vdd_3v3_reg>;

Does this work? simple-panel supports only a single power supply. Both
of these seem to be always on, so I guess it doesn't matter all that
much, and if indeed both of these are required to power the panel then
this is the correct thing to do in the DTS.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140620/2970f5f2/attachment-0001.sig>
