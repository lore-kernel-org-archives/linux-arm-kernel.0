From: b32955@freescale.com (Huang Shijie)
Date: Thu, 28 Nov 2013 11:34:29 +0800
Subject: [PATCH 00/23] mtd: st_spi_fsm: Add new device
In-Reply-To: <20131127115226.GC3296@lee--X1>
References: <1385137380-28968-1-git-send-email-lee.jones@linaro.org>
 <20131127040723.GZ9468@ld-irv-0074.broadcom.com>
 <20131127115226.GC3296@lee--X1>
Message-ID: <5296B9C5.3060704@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?11?27? 19:52, Lee Jones ??:
> However, as we send entire 'message sequences' to the FSM Controller
> as opposed to merely OPCODEs we would have to extract the OPCODE from
> flash->command[0] and call our own functions to craft the correct
> 'message sequence' for the task. For this reason we rejected the idea
> and went with a stand-alone driver.
>
could you send me the datasheet of your spi nor controller?
I can change my code if it really not good enough.

we can store the opcode to a field, such as spi_nor_write_op.
> The framework which Huang is proposing suffers from the same issues.
> Only providing read(), write(), read_reg() and write_reg() doesn't
> work for our use-case, as we'd have to decode the flash->command[0] and
> invoke our own internal routines as before.
>
> The only framework with would work for us would consist almost all
> of the important functions such as; read(), write(), erase(),
> wait_busy(), read_jedec(), read_status_reg(), write_status_reg(),
> read_control_reg(), write_control_reg(), etc. However, this approach
>   
read_jedec() can be replaced by read_reg(0x9f);

read_status() can be replaced by read_reg(0x5);

....

write_control_reg() can be replaced by write_reg(xx).


Please correct me if i am wrong.

IMHO, the current four hooks for spi-nor{} can do all the things.

      read/write/read_reg/write_reg.

thanks
Huang Shijie
