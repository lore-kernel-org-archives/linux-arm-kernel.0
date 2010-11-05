From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 5 Nov 2010 10:44:18 +0300
Subject: Booting CNS3420 EVB v 1.3 failed with 2.6.36 (and 2.6.35)
In-Reply-To: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
References: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
Message-ID: <20101105074418.GA5864@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 11:08:25AM +0800, Lin Mac wrote:
> Here's the my summary:
> 1. Booting CNS3420 EVB v 1.3 failed with linux 2.6.36 and .35

I see you use zImage (bootpImage) for booting. The stock U-Boot
image from Cavium has incorrect (non-mainline) machid. You have
to specify a correct one and thus use uImage.

So, you need to build the kernel with the following command:

make LOADADDR=0x200000 uImage

And boot with these commands:

setenv machid ad8
setenv bootargs console=ttyS0,38400 ip=on
tftp 100000 uImage
bootm 100000

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
