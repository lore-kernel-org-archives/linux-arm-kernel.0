From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Wed, 24 Mar 2010 23:13:52 +0100
Subject: [PATCH 1/5] ARM: define the PrimeCell DMA API
In-Reply-To: <e9c3a7c21003241501x1f1ed857pcaaaf8ea8dc563ec@mail.gmail.com>
References: <1268056327-16577-1-git-send-email-linus.walleij@stericsson.com>
	<e9c3a7c21003241408g2a704425g47ccdfb60d606683@mail.gmail.com>
	<CEE6BB42CAD6E947908279175AF8470A0391EEB1@EXDCVYMBSTM006.EQ1STM.local>
	<e9c3a7c21003241501x1f1ed857pcaaaf8ea8dc563ec@mail.gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A0391EEB9@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Dan]

> What are your semantics for keeping the transaction information alive
> until it gets consumed.  Currently the dma_ctrl_flags have the
> DMA_CTRL_ACK bit to specify that the descriptor not be
> recycled/destroyed until the client has a chance to attach a dependent
> operation.  Seems you need something similar to indicate that the
> residue information not be destroyed until it is consumed.  In other
> words how does a client guarantee that the engine provides the
> information it needs?

Well exactly to avoid that kind of trouble I STOP (or PAUSE),
get numer of bytes left, then terminate in that order. This
keeps the descriptor.

Perhaps it's better to keep the two functions _pause() and
_get_residue() and indicate that device_terminate_all()
may destroy the state.

Yours,
Linus Walleij
