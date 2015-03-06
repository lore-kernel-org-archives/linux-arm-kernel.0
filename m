From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 6 Mar 2015 07:36:29 +0100
Subject: [PATCH v2 1/4] i2c: sunxi: Add Reduced Serial Bus (RSB) support
In-Reply-To: <20150305220801.GE4522@lukather>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-2-git-send-email-wens@csie.org>
 <20150304172710.GA884@katana> <20150305182817.GB4911@lukather>
 <20150305184044.GA881@katana> <20150305220801.GE4522@lukather>
Message-ID: <20150306063628.GA883@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From that regard, RSB is a multiple device bus, using addresses, just
> like I2C. The way it communicates is basically the one used by P2WI.

I am not keen to allow everything which "is a bus and has addresses"
into the I2C realm. The addresses are 12 bit, whilst I2C has at maximum
10 bit which is rarely used, so mostly 7 bit are used. It has a runtime
readdressing mechanism which is not present in standard I2C. And if you
look at the protocol with no acks but parities, IMO it doesn't look
closer to I2C than to other two wire protocols. So, being in I2C needs
more arguments.

And while the outcome could be that it really makes sense to add RSB to
I2C with I2C_FUNCS_RSB added, it could also be that there is a more
suitable place for custom busses in the kernel.

Also, the fact that P2WI is in I2C is not an argument IMO. It could have
been a mistake to pick it up.

> So really, it just is more I2C-alike than P2WI has ever been.

Because it has addresses? I disagree.

> Good thing that we are not talking about a full review then, but more
> a philosophical discussion.

Exactly. This is why I wanted to bring this in early.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150306/f9dc52a8/attachment.sig>
