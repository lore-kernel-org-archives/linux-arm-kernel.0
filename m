From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Sep 2016 11:54:29 +0100
Subject: next-20160914 build: 2 failures 3 warnings (next-20160914)
In-Reply-To: <2300987.vYzazfRX5F@wuerfel>
References: <E1bk5OS-0000Vu-1C@optimist> <20160914171137.GF27974@sirena.org.uk>
 <20160919102150.GI10189@sirena.org.uk> <2300987.vYzazfRX5F@wuerfel>
Message-ID: <20160919105429.GK10189@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 12:31:04PM +0200, Arnd Bergmann wrote:

> My guess is that this is indeed the correct fix, but I don't understand
> at all what the function does, and Marcin Niestroj said the same thing,
> he just copied the code from a driver that is always built-in.

Yes, most of the code is copied from regmap-irq.  Setting the parent is
needed for edge triggered interrupts that don't latch state when
disabled but isn't needed in the general case.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/5befb5da/attachment.sig>
