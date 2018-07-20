From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 21 Jul 2018 00:41:41 +0200
Subject: [PATCH v3 0/3] i2c: at91: slave mode support
In-Reply-To: <20180716094037.1843-1-ludovic.desroches@microchip.com>
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
Message-ID: <20180720224141.lawanibd7v4hmbym@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> [Ludovic Desroches]
> Changes in v3:
>  - rebase (cherry-pick was enough)

Thanks for the rebase. I wonder, though, I recall to had more
complicated issues. However...

>  - fix checkpatch errors
>  - tests:
>    - hangs with a SAMA5D4 (master and slave on different busses) after about
>    100 transfers. It's the firs time I do this test.
>    - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
>    I don't know if it's a regression. I don't remember having seen this
>    behavior previously.
>    I think it's worth taking those patches even if there are some possible
>    bugs. It'll allow to get more people using it and so to consolidate the
>    slave mode support.

I really want to see those patches go upstream, too. But I am also not a
big fan of delivering the user something with known issues. Especially
not when they affect the main feature to be added. My rationale here is
that someone who is able to fix the issues remaining will also be able
to pick up and apply patches.

Maybe, maybe if it was to be enabled by a special
I2C_AT91_SLAVE_EXPERIMANTEL symbol with lots of explanations. I need to
think twice about that, though.

Speaking of Kconfig, I think this series needs to place a

	select I2C_SLAVE

somewhere.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180721/c34789bd/attachment.sig>
