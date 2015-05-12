From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Tue, 12 May 2015 15:26:31 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.2
In-Reply-To: <4187963.lx6hRMGsoN@wuerfel>
References: <1431371529-22593-1-git-send-email-dinguyen@opensource.altera.com>
 <1431371529-22593-2-git-send-email-dinguyen@opensource.altera.com>
 <4187963.lx6hRMGsoN@wuerfel>
Message-ID: <555261F7.8060409@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2015 03:20 PM, Arnd Bergmann wrote:
> On Monday 11 May 2015 14:12:09 dinguyen at opensource.altera.com wrote:
>> SoCFPGA updates for v4.2
>> - Add big endian support
>> - Add earlyprintk support on UART1 that is used on Arria10
>> - Remove the need to map uart_io_desc
>>
> 
> The patches look almost ok, but please clarify a minor issue:
> 
>  static void __init socfpga_map_io(void)
>  {
>         socfpga_scu_map_io();
> -       iotable_init(&uart_io_desc, 1);
> -       early_printk("Early printk initialized\n");
>  }
> 
> 
> You have a map_io() function here, which means that the debug_ll_io_init()
> function is not called. How does the debug_ll mapping get created then?
> 
> If it's not, I think the best solution is to remove the socfpga_map_io()
> function entirely, and turn socfpga_scu_base_addr into a local variable
> in arch/arm/mach-socfpga/platsmp.c that gets set using of_iomap().
> 

Yes, you're right! Thanks for catching that. Will send a patch for this.

Dinh
