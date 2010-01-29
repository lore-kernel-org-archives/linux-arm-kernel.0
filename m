From: chetannanda@gmail.com (Chetan Nanda)
Date: Fri, 29 Jan 2010 22:18:55 +0530
Subject: not able to understand 'icedcc_putc'
Message-ID: <7f245da81001290848n5630c6b6q68f19369fd0ad5aa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am newbie to ARM core. This might be a very silly question, but I am not
able to understand how 'icedcc_putc' function prints a character on console
(UART).

############3
static void icedcc_putc(int ch)
{
    int status, i = 0x4000000;

    do {
        if (--i < 0)
            return;

        asm volatile ("mrc p14, 0, %0, c0, c0, 0" : "=r" (status));
    } while (status & 2);

    asm("mcr p14, 0, %0, c1, c0, 0" : : "r" (ch));
}
#############

Thanks for your help

~cnanda
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100129/22e360fb/attachment-0001.htm>
