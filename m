From: clagix@gmail.com (Guido Classen)
Date: Tue, 15 Jun 2010 20:36:47 +0200
Subject: [PATCH] Resend: at91rm9200 static memory controller initialization
Message-ID: <AANLkTinmuxJ9GhzZVOb51THgYe7208y7fQAzoyg2tcgM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello mailing list,

I resend the last patch becase it seams to be garbaged by google mail.

This patch adds AT91RM9200 static memory controller initialization based
on a structure 'at91rm9200_smc_config'. It is simlar to a patch provided
by Andrew Victor for the AT91SAM9 family (sam9_smc.[ch]).

The code can be used like this:

        /*
         * Setup static memory controller chip select for external quad UART
         *
         */
        static const struct __initdata at91rm9200_smc_config
                quad_uart_cs_config = {
                .wait_states          = 16,
                .data_float_time      = 0,
                .byte_access_type     = AT91RM9200_BAT_8_BIT,
                .data_bus_width       = AT91RM9200_DATA_BUS_WIDTH_8,
                .data_read_protocol   = AT91RM9200_DRP_STANDARD,
                .address_to_cs_setup  = AT91RM9200_ACSS_STANDARD,
                .rw_setup             = 2,
                .rw_hold              = 2
        };

        if (at91rm9200_smc_configure(CCM2200_QUAD_UART_CS,
                                     &quad_uart_cs_config ) != 0 ) {
                printk( KERN_ERR
                        "Unable to configure static memory controller\n" );
                return -EIO;
	}


I am new at ARM linux and not familiar with the naming conventions.
Please review the patch and give comments.

Best regards

  Guido Classen

Signed-off-by: Guido Classen <clagix@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: at91rm9200_smc_init.patch
Type: application/octet-stream
Size: 7019 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100615/76c823f8/attachment-0001.obj>
