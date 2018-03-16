From: david@lechnology.com (David Lechner)
Date: Fri, 16 Mar 2018 12:20:02 -0500
Subject: [PATCH v8 42/42] ARM: dts: da850: Add clocks
In-Reply-To: <1521168778-27236-43-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-43-git-send-email-david@lechnology.com>
Message-ID: <cf0c4153-b65d-da57-cd0f-0a16cb186377@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2018 09:52 PM, David Lechner wrote:
> This adds clock provider nodes for da850 and wires them up to all of the
> devices.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

...

This is the mcasp0: mcasp at 100000 node...

> @@ -560,6 +720,7 @@
>   			dmas = <&edma0 1 1>,
>   				<&edma0 0 1>;
>   			dma-names = "tx", "rx";
> +			clocks = <&psc1 7>;

After some testing, it looks like it needs to be:

+			power-domains = <&psc1 7>;

instead of

+			clocks = <&psc1 7>;

>   		};
>   
>   		lcdc: display at 213000 {
