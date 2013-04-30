From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Apr 2013 22:42:23 +0200
Subject: [PATCH 1/5] dmaengine: ste_dma40: Allow memcpy channels to be
 configured from DT
In-Reply-To: <1367336497-10650-1-git-send-email-lee.jones@linaro.org>
References: <1367336497-10650-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201304302242.24002.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 April 2013, Lee Jones wrote:
> @@ -6,6 +6,8 @@ Required properties:
>  - reg-names: Names of the above areas to use during resource look-up
>  - interrupt: Should contain the DMAC interrupt number
>  - #dma-cells: must be <3>
> +- memcpy-channels: Channels to be used for memcpy
> +- memcpy-num-chans: Number of channels to be used for memcpy
>  
>  Optional properties:
>  - dma-channels: Number of channels supported by hardware - if not present
> @@ -21,6 +23,8 @@ Example:
>                 interrupts = <0 25 0x4>;
>  
>                 #dma-cells = <2>;
> +               memcpy-channels  = <56, 57, 58, 59, 60>;
> +               memcpy-num-chans = <5>;
>                 dma-channels = <8>;
>         };
>  

I think you should remove the memcpy-num-chans property and instead evaluate the
length of the memcpy-channels property. Aside from this, it looks fine.

	Arnd
