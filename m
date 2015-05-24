From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 24 May 2015 20:54:01 +0200
Subject: [PATCH] ARM: BCM5301X: activate some additional options in pl310
 cache controller
In-Reply-To: <1432493418-12933-1-git-send-email-hauke@hauke-m.de>
References: <1432493418-12933-1-git-send-email-hauke@hauke-m.de>
Message-ID: <CACna6ryXjmEgw+dzz5OgS=9rUn8ng9S6rD7eBoQ8dqycG5vJ9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2015 at 20:50, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> In the default Broadcom SDK the shared override is activated for this
> cache controller, do the same in the upstream code. Data and
> instruction prefetching is not activated by default for this cache
> controller on the bcm53xx SoC, do it manually like it is done in the
> vendor SDK.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/arm/boot/dts/bcm5301x.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> index 78aec62..7d1578a 100644
> --- a/arch/arm/boot/dts/bcm5301x.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> @@ -78,6 +78,9 @@
>                         compatible = "arm,pl310-cache";
>                         reg = <0x2000 0x1000>;
>                         cache-unified;
> +                       arm,shared-override;
> +                       arm,prefetch-data = <1>;
> +                       arm,prefetch-instr = <1>;
>                         cache-level = <2>;
>                 };
>         };
> --
> 2.1.4

Fwd-ing to Felix, who was also looking at this I believe.

-- 
Rafa?
