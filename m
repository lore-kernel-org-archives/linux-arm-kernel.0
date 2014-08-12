From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Aug 2014 18:25:52 +0100
Subject: [PATCH 6/6] ARM: dts: Add tps65090 FETs constraints
In-Reply-To: <1407861868-20097-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-7-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140812172552.GU17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 06:44:28PM +0200, Javier Martinez Canillas wrote:
> The tps65090 PMU data manual [0] has a table that list the
> "Recommended operating conditions" for each regulator. Add
> the information about the FET constraints to its dtsi file.

>  		tps65090_fet1: fet1 {
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <17000000>;
>  		};

No, this is completely broken and exactly the sort of thing that makes
doing generic device .dtsi a bad idea.  We have absolutely no idea if
these voltage ranges are suitable for use on a given board using the
device, these are the design limits for the device but tell us nothing
about the system they are deployed in.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140812/9a43eb1f/attachment-0001.sig>
