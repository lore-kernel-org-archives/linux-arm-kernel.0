From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 21 Oct 2014 09:41:09 +0200
Subject: [PATCH v7 02/10] ARM: add lolevel debug support for asm9260
In-Reply-To: <alpine.DEB.2.11.1410210920130.5308@nanos>
References: <1413875672-7894-1-git-send-email-linux@rempel-privat.de>
 <1413875672-7894-3-git-send-email-linux@rempel-privat.de>
 <alpine.DEB.2.11.1410210920130.5308@nanos>
Message-ID: <54460E15.1060500@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.10.2014 um 09:20 schrieb Thomas Gleixner:
> On Tue, 21 Oct 2014, Oleksij Rempel wrote:
>> +	config DEBUG_ASM9260_UART
>> +		bool "Kernel low-level debugging via asm9260 UART"
>> +		depends on MACH_ASM9260
>> +		help
>> +		  Say Y here if you want the debug print routines to direct
>> +		  their output to an UART or USART port on asm9260 based
>> +		  machines.
>> +
>> +		    DEBUG_UART_PHYS | DEBUG_UART_VIRT
>> +
>> +		    0x80000000      | 0xf0000000     | UART0
>> +		    0x80004000      | 0xf0004000     | UART1
>> +		    0x80008000      | 0xf0008000     | UART2
>> +		    0x8000c000      | 0xf000c000     | UART3
>> +		    0x80010000      | 0xf0010000     | UART4
>> +		    0x80014000      | 0xf0014000     | UART5
>> +		    0x80018000      | 0xf0018000     | UART6
>> +		    0x8001c000      | 0xf001c000     | UART7
>> +		    0x80020000      | 0xf0020000     | UART8
>> +		    0x80024000      | 0xf0024000     | UART9
> 
> What's the point of having this list in Kconfig?

1. no public documentation
2. How match is it different to this:

        config DEBUG_MSM_UART
                bool "Kernel low-level debugging messages via MSM UART"
                depends on ARCH_MSM
                help
                  Say Y here if you want the debug print routines to direct
                  their output to the serial port on MSM devices.

                  ARCH                DEBUG_UART_PHYS   DEBUG_UART_BASE   #
                  MSM7X00A, QSD8X50   0xa9a00000        0xe1000000
  UART1
                  MSM7X00A, QSD8X50   0xa9b00000        0xe1000000
  UART2
                  MSM7X00A, QSD8X50   0xa9c00000        0xe1000000
  UART3

                  MSM7X30             0xaca00000        0xe1000000
  UART1
                  MSM7X30             0xacb00000        0xe1000000
  UART2
                  MSM7X30             0xacc00000        0xe1000000
  UART3

                  Please adjust DEBUG_UART_PHYS and DEBUG_UART_BASE
configuration
                  options based on your needs.

        config DEBUG_QCOM_UARTDM
                bool "Kernel low-level debugging messages via QCOM UARTDM"
                depends on ARCH_QCOM
                help
                  Say Y here if you want the debug print routines to direct
                  their output to the serial port on Qualcomm devices.

                  ARCH      DEBUG_UART_PHYS   DEBUG_UART_BASE
                  APQ8084   0xf995e000        0xfa75e000
                  MSM8X60   0x19c40000        0xf0040000
                  MSM8960   0x16440000        0xf0040000
                  MSM8974   0xf991e000        0xfa71e000

                  Please adjust DEBUG_UART_PHYS and DEBUG_UART_BASE
configuration
                  options based on your needs.


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141021/1132641d/attachment.sig>
