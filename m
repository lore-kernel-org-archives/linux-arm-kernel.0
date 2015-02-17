From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Feb 2015 15:16:08 +0000
Subject: [PATCH v4 6/6] ARM: shmobile: ape6evm dts: Drop console=
 bootargs parameter
In-Reply-To: <1424185486-3017-7-git-send-email-geert+renesas@glider.be>
References: <1424185486-3017-1-git-send-email-geert+renesas@glider.be>
 <1424185486-3017-7-git-send-email-geert+renesas@glider.be>
Message-ID: <20150217151608.GN8994@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 03:04:46PM +0000, Geert Uytterhoeven wrote:
> Since ("ARM: shmobile: r8a73a4: ape6evm: Remove legacy platform"),
> ape6evm is restricted to booting from DT, so chosen/stdout-path is
> always used, and we can drop the "console=" parameter from
> chosen/bootargs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - New.
> ---
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> index 44c4cac1820a4dfe..f9e81512201a2ec4 100644
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> @@ -22,7 +22,7 @@
>  	};
>  
>  	chosen {
> -		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
> +		bootargs = "ignore_loglevel root=/dev/nfs ip=dhcp rw";
>  		stdout-path = &scifa0;

I'd strongly recommend that you also pass the configuration explicitly
here, so as to avoid nasty surprises. For that you can either use a path
or an alias, depending on what the rest of your DT looks like:

	stdout-path = "/path/to/scifa0:115200n8"

	stdout-path = "serial0:115200n8"

Thanks,
Mark.
