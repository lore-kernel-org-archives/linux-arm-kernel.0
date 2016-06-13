From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Mon, 13 Jun 2016 17:14:18 +0200
Subject: [PATCH v2 1/3] spi: xilinx: Remove bitbang and register with spi
 core
In-Reply-To: <1464601609-5095-1-git-send-email-nagasure@xilinx.com>
References: <1464601609-5095-1-git-send-email-nagasure@xilinx.com>
Message-ID: <CAPybu_1bvXtQFeC8pPhZ4R9s8q2DC=06gQN015exi-9jQ9Y13A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naga


There is some functionality removed by this patch:

- Auto Detection of fifo size.
- Non irq mode (which is a great improvement on some systems)


Also some comments have been removed for apparently no reason:

> -       u32 cs_inactive;        /* Level of the CS pins when inactive*/
> +       int buffer_size;
> +       u32 cs_inactive;
>

And the rename of some vars increases the patch size:
-       struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
+       struct xilinx_spi *xqspi = spi_master_get_devdata(qspi->master);

I am not a big fan of code generation via macros:
#define XSPI_FIFO_READ(size, type)
Interpreting kernel oops or greping the code is much more difficult.
Why not using function parameters instead?

Could you add me in cc next time? Although I am not in the credit file
I have authored a good bunch of the file and also we relay on this
driver on our products.



Best regards!
