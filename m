From: peter@hurleysoftware.com (Peter Hurley)
Date: Sat, 7 Nov 2015 17:36:34 -0500
Subject: [PATCH] tty: amba-pl011: add options to earlycon for 32-bit reg
 access
In-Reply-To: <563CF8AF.50808@codeaurora.org>
References: <1446770267-26749-1-git-send-email-timur@codeaurora.org>
 <563C07C8.9060506@hurleysoftware.com> <563C09BB.9030706@codeaurora.org>
 <563C1409.4070804@hurleysoftware.com> <563CF8AF.50808@codeaurora.org>
Message-ID: <563E7CF2.60609@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2015 01:59 PM, Timur Tabi wrote:
> On 11/05/2015 08:44 PM, Peter Hurley wrote:
>> Or better yet, for sbsa32 earlycon, just use the existing port type constructs.
>> So,
>>
>>     earlycon=pl011,mmio32,0x3ced1000
>>
>> which will set port->iotype to UPIO_MEM32, which in turn can be used to select
>> the correct i/o width in pl011_putc().
> 
> That's a great idea.  But why aren't we using it for pl011_write()?

I'll note that when I review Russell's v2 series, if necessary.
What is the plan to introduce the SBSA32 support? After the ACPI support is
upstreamed?

Regards,
Peter Hurley


> static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
>     unsigned int reg)
> {
>     void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
> 
>     if (uap->port.iotype == UPIO_MEM32)
>         writel(val, addr);
>     else
>         writew(val, addr);
> }
> 
> 
