From: mike@compulab.co.il (Mike Rapoport)
Date: Sun, 10 Oct 2010 08:46:45 +0200
Subject: [PATCH] [ARM] dove: add support for CM-A510 machine.
In-Reply-To: <AANLkTinVMczTFaQNyYinHdFzo1pzi2+SGHzrwikYCZFa@mail.gmail.com>
References: <1286436985-24224-1-git-send-email-kostyas@compulab.co.il>
	<AANLkTinVMczTFaQNyYinHdFzo1pzi2+SGHzrwikYCZFa@mail.gmail.com>
Message-ID: <4CB16155.6090002@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

saeed bishara wrote:
> On Thu, Oct 7, 2010 at 9:36 AM, Konstantin Sinyuk
> <kostyas@compulab.co.il> wrote:
>> Signed-off-by: Konstantin Sinyuk <kostyas@compulab.co.il>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---

[ snip ]

>> +/* Board Init */
>> +static void __init cm_a510_init(void)
>> +{
>> +       /*
>> +        * Basic Dove setup. Needs to be called early.
>> +        */
>> +       dove_init();
>> +
>> +       dove_ge00_init(&cm_a510_ge00_data);
>> +       dove_ehci0_init();
>> +       dove_ehci1_init();
>> +       dove_sata_init(&cm_a510_sata_data);
>> +       dove_sdio0_init();
>> +       dove_sdio1_init();
>> +       dove_spi0_init();
>> +       dove_spi1_init();
>> +       dove_uart0_init();
>> +       dove_uart1_init();
>> +       dove_i2c_init();
>> +       spi_register_board_info(cm_a510_spi_flash_info,
>> +                               ARRAY_SIZE(cm_a510_spi_flash_info));
> Konstantin, are you sure your board has all the above interfaces?
> other than that the patch looks fine to me.

Our board indeed has all the above interfaces. Moreover, it uses other Dove 
interfaces that haven't yet hit the mainline.

>> +}
>> +
>> +MACHINE_START(CM_A510, "Compulab CM-A510 Board")
>> +       .phys_io        = DOVE_SB_REGS_PHYS_BASE,
>> +       .io_pg_offst    = ((DOVE_SB_REGS_VIRT_BASE) >> 18) & 0xfffc,
>> +       .boot_params    = 0x00000100,
>> +       .init_machine   = cm_a510_init,
>> +       .map_io         = dove_map_io,
>> +       .init_irq       = dove_init_irq,
>> +       .timer          = &dove_timer,
>> +MACHINE_END
>> --
>> 1.7.0.4


-- 
Sincerely yours,
Mike.
