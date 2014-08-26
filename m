From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Aug 2014 20:04:49 -0700
Subject: [PATCH] ARM: shmobile: lager: correct memory map
In-Reply-To: <1409021623-10633-1-git-send-email-horms+renesas@verge.net.au>
References: <1409021623-10633-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAOesGMieRk4Dvg=gxTgcVssARkK6DeoaVyK8619B2N5=wwo=Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 25, 2014 at 7:53 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> The base address of the second memory region on the lager
> board is 0x140000000. Update the tag used in the dts file accordingly.
>
> This is a documentation fix and should have no run-time affect.
>
> This problem was introduced when the second memory region
> was added to the lager dts file by 62bc32a2573c4219
> ("ARM: shmobile: Include all 4 GiB of memory on Lager)"
> in v3.14.
>
> Reported-by: NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 0118cbf..84dcafa 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -32,7 +32,7 @@
>                 reg = <0 0x40000000 0 0x40000000>;
>         };
>
> -       memory at 180000000 {
> +       memory at 140000000 {

That should even be "memory at 1,40000000".


-Olof
