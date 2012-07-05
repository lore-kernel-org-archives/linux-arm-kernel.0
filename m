From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Jul 2012 12:25:27 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <20120705121029.782b5346@skate>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <20120705110251.596331e0@skate> <20120705094824.GO17534@lunn.ch>
 <20120705121029.782b5346@skate>
Message-ID: <20120705102527.GQ17534@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I've looked at the datasheet for the 88F6281, and the GPIO registers
> look fairly similar with Armada 370/XP, except that:
> 
>  * On 88F6281, there are two GPIO banks, while on Armada 370/XP it's a
>    continuous range of registers that control the GPIOs. But it can be
>    assimilated as one bank handling more than 32 GPIOs. So shouldn't be
>    a big problem to handle.

The number of banks varies. Orion5x has one, Dove has three, etc.

> 
>  * The Armada 370/XP have additional set/clear registers that allow to
>    modify the GPIO states without having to do a read/mask/write
>    sequence, which is nicer on SMP. I guess we can handle that as a
>    variant inside the driver without too much problem.
> 
> Marvell has given me a 88F6282 eval board, so I guess they are fine
> with me spending some time ensuring that the new code works properly on
> the previous platforms, especially in this case where the amount of
> work does not seem to be enormous to keep the compatibility.

That is good to hear.

Thanks
	Andrew
