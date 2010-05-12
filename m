From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 May 2010 21:13:56 +0100
Subject: asmlinkage
In-Reply-To: <AANLkTimYY_ljcTwRTQSaVBtUGZE_3dWX1PUbNFPXzTnR@mail.gmail.com>
References: <AANLkTimYY_ljcTwRTQSaVBtUGZE_3dWX1PUbNFPXzTnR@mail.gmail.com>
Message-ID: <20100512201356.GA5611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 12:49:24AM +0300, Alexander (Sasha) Sirotkin wrote:
> Sorry for yet another basic question, but why "asmlinkage" is an empty macro
> on ARM?

ARM doesn't require any special API modification to call functions
from assembly.

x86 has two different calling conventions - one is to stack all function
arguments, the other passes some arguments via registers.  asmlinkage
selects between them.

However, we keep the asmlinkage labelling on ARM because it's useful to
indicate which functions are called by assembly - and therefore which
need closer inspection when their signature is changed to make sure the
assembly calling them is also fixed.
