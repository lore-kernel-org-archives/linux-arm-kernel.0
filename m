From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 14 Jul 2014 10:16:12 +0000
Subject: [PATCH 2/2] tty: serial: fsl_lpuart: add 32-bit register
 interface support
In-Reply-To: <20140712005122.GA31974@kroah.com>
References: <1405057302-26041-1-git-send-email-jingchang.lu@freescale.com>
 <1405057302-26041-3-git-send-email-jingchang.lu@freescale.com>
 <20140712005122.GA31974@kroah.com>
Message-ID: <ea314532262d449aac50e4eb0a79f9f6@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Greg KH [mailto:gregkh at linuxfoundation.org]
>Sent: Saturday, July 12, 2014 8:51 AM
>To: Lu Jingchang-B35083
>Cc: linux-serial at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: add 32-bit register
>interface support
>
>On Fri, Jul 11, 2014 at 01:41:42PM +0800, Jingchang Lu wrote:
>> This add the 32-bit register version LPUART support with big-endian
>> byte order.
>>
>> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>> ---
>>  drivers/tty/serial/fsl_lpuart.c | 653
>> +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 643 insertions(+), 10 deletions(-)
>
>You didn't even test build this patch:
>
>  CC [M]  drivers/tty/serial/fsl_lpuart.o
>drivers/tty/serial/fsl_lpuart.c: In function ?lpuart_suspend?:
>drivers/tty/serial/fsl_lpuart.c:1856:22: error: ?lpuart32_reg? undeclared
>(first use in this function)
>   uart_suspend_port(&lpuart32_reg, &sport->port);
>                      ^
>
>No quicker way to make me grumpy...
>
>Please take some time to do this right.
>
>greg k-h

Sorry for the mistake, I only test the functionality without option of CONFIG_PM_SLEEP,
I will fix that and send the patch again. Thanks.



Best Regards,
Jingchang
