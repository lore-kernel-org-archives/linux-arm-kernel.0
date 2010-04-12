From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 20:10:07 +0100
Subject: [PATCH 1/2] AT91 slow-clock suspend: don't wait when turning
	PLLs off
In-Reply-To: <w2ocd73a99e1004061427t322f8d4cmecd708ad16580f00@mail.gmail.com>
References: <20100303213329.GA500@alarsen.net>
	<w2ocd73a99e1004061427t322f8d4cmecd708ad16580f00@mail.gmail.com>
Message-ID: <20100412191006.GJ3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 06, 2010 at 11:27:55PM +0200, Andrew Victor wrote:
> hi Anders,
> 
> > From: Julien Langer <julien.langer@gmail.com>
> >
> > AT91: when turning off the PLLs during suspend, don't wait for the lock flag
> > to be set. Previously the code would always run into the loop limitation
> > of 1000 iterations because the flag is never set when turning the PLLs off.
> >
> > Signed-off-by: Julien Langer <julien.langer@gmail.com>
> > Signed-off-by: Anders Larsen <al@alarsen.net>
> > Cc: Andrew Victor <avictor.za@gmail.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> During suspend we set the MULA and MULB bits to 0 to disable the
> PLL's.  When disabled, the PLLs will never "lock".
> 
>    Acked-by: Andrew Victor <linux@maxim.org.za>
> 
> 
> Russell:  This is patch 5975/1 in the patch-system.

Thanks; I see your ack has been added to that patch.  Should I assume that
this is for -rc rather than -devel?
