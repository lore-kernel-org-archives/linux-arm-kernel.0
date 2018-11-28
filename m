From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 27 Nov 2018 18:01:14 -0800
Subject: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
In-Reply-To: <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
Message-ID: <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sugaya Taichi (2018-11-18 17:01:07)
> Add DT bindings document for Milbeaut trampoline.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/soc/socionext/socionext,m10v.txt     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> new file mode 100644
> index 0000000..f5d906c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> @@ -0,0 +1,12 @@
> +Socionext M10V SMP trampoline driver binding
> +
> +This is a driver to wait for sub-cores while boot process.
> +
> +- compatible: should be "socionext,smp-trampoline"
> +- reg: should be <0x4C000100 0x100>
> +
> +EXAMPLE
> +       trampoline: trampoline at 0x4C000100 {

Drop the 0x part of unit addresses.

> +               compatible = "socionext,smp-trampoline";
> +               reg = <0x4C000100 0x100>;

Looks like a software construct, which we wouldn't want to put into DT
this way. DT doesn't describe drivers.
