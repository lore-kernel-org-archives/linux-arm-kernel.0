From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Wed, 14 Oct 2015 10:54:35 +0200
Subject: [PATCH v2 1/4] dt-bindings: Document the STM32 DMA bindings
In-Reply-To: <1444745127-1105-2-git-send-email-cedric.madianga@gmail.com>
References: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
 <1444745127-1105-2-git-send-email-cedric.madianga@gmail.com>
Message-ID: <CAOAejn1hG34-d=Eq0SUDoay=B04sqoSNnxL++djBDrzdT0f61w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> +5. A 32bit mask specifying the DMA FIFO configuration
> + -bit 0-1: Fifo threshold
> +       0x0: 1/4 full FIFO
> +       0x1: 1/2 full FIFO
> +       0x2: 3/4 full FIFO
> +       0x3:full FIFO
> + -bit 2: Direct mode
> +       0x0: enabled
> +       0x1: disabled
> +
Finally, I find a way to handle the above inputs outside DT.
So, I will remove it from DT in the next version.
Thanks.

To sum-up, the remaining information that the client will have to
specify from DT are describing below.
Is it ok ?
> + -bit 9: Peripheral Increment Address
> +       0x0: no address increment between transfers
> +       0x1: increment address between transfers
> + -bit 10: Memory Increment Address
> +       0x0: no address increment between transfers
> +       0x1: increment address between transfers
> + -bit 15: Peripheral Increment Offset Size
> +       0x0: offset size is linked to the peripheral bus width
> +       0x1: offset size is fixed to 4 (32-bit alignment)
> + -bit 16-17: Priority level
> +       0x0: low
> +       0x1: medium
> +       0x2: high
> +       0x3: very high

BR,
Cedric
