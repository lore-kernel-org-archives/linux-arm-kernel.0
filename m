From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 Mar 2017 13:01:38 +0000
Subject: [PATCH v2 05/23] MAINTAINERS: Add file patterns for dove device
 tree bindings
In-Reply-To: <1489324627-19126-6-git-send-email-geert@linux-m68k.org>
References: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
 <1489324627-19126-6-git-send-email-geert@linux-m68k.org>
Message-ID: <20170313130138.GV11350@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Sun, Mar 12, 2017 at 02:16:49PM +0100, Geert Uytterhoeven wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
> Please apply this patch directly if you want to be involved in device
> tree binding documentation for your subsystem.
> 
> v2:
>   - No changes.
> 
> Impact on next-20170310:
> 
> +Jason Cooper <jason@lakedaemon.net> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
> +Andrew Lunn <andrew@lunn.ch> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
> +Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
> +Gregory Clement <gregory.clement@free-electrons.com> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
>  Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>  Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> +linux-arm-kernel at lists.infradead.org (moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support)
>  devicetree at vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>  linux-kernel at vger.kernel.org (open list)
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6428d3c82fce9670..ce461fefec6c9463 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1486,6 +1486,7 @@ M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>  M:	Gregory Clement <gregory.clement@free-electrons.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/dove/

I'm not opposed to the idea, but I'm not seeing how we can do this
completely.  What you've added only covers dove soc bindings.  There's
orion5x, kirkwood, and all the newer mvebu socs.  Not to mention a lot
of IP blocks we care about that aren't SoC- or Marvell-specific.

The dts files have a much more clear file pattern -> maintainer pairing.
Perhaps we should make checkpatch smarter?  e.g. compatible strings
found in changed binding docs are searched for in dts{i} files.  Hits
are mapped to maintainers.

thoughts?

thx,

Jason.
