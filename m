From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 6 Apr 2010 23:27:55 +0200
Subject: [PATCH 1/2] AT91 slow-clock suspend: don't wait when turning PLLs
	off
In-Reply-To: <20100303213329.GA500@alarsen.net>
References: <20100303213329.GA500@alarsen.net>
Message-ID: <w2ocd73a99e1004061427t322f8d4cmecd708ad16580f00@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Anders,

> From: Julien Langer <julien.langer@gmail.com>
>
> AT91: when turning off the PLLs during suspend, don't wait for the lock flag
> to be set. Previously the code would always run into the loop limitation
> of 1000 iterations because the flag is never set when turning the PLLs off.
>
> Signed-off-by: Julien Langer <julien.langer@gmail.com>
> Signed-off-by: Anders Larsen <al@alarsen.net>
> Cc: Andrew Victor <avictor.za@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>

During suspend we set the MULA and MULB bits to 0 to disable the
PLL's.  When disabled, the PLLs will never "lock".

   Acked-by: Andrew Victor <linux@maxim.org.za>


Russell:  This is patch 5975/1 in the patch-system.
