From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Nov 2013 11:27:54 +0000
Subject: [PATCHv5] dmaengine: Add support for BCM2835
In-Reply-To: <CAHp75Vf3CJNgSiSjoZ6dYjRRHWN4bTpMxRTLG37+wwtEsQbq4g@mail.gmail.com>
References: <52864BBC.7000506@koalo.de> <1384537403.14845.131.camel@smile>
 <20131115175155.GQ16735@n2100.arm.linux.org.uk>
 <CAHp75Vf3CJNgSiSjoZ6dYjRRHWN4bTpMxRTLG37+wwtEsQbq4g@mail.gmail.com>
Message-ID: <20131116112754.GT15393@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 11:37:54AM +0200, Andy Shevchenko wrote:

> The reason why I was asking about I'm just wondering what we have to do
> with existing drivers. Shall we convert them to be initialized as normal
> platform drivers instead of subsys_initcall?

We should in general be moving in that direction however it does need a
bit of care to make sure that there aren't any dependencies which do
things like discard error codes, fail to check errors or treat errors as
hard failures.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/b35b6ef1/attachment.sig>
