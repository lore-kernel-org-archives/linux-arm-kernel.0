From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Sep 2012 10:13:16 +0000
Subject: [PATCH 00/19] First HREF Device Tree enablement patch-set
In-Reply-To: <CACRpkdZ-QpHzeEBO=RFVe-8S2DG4-thhwW9iVbAMXZrOe-FnAw@mail.gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <201209071358.38598.arnd@arndb.de>
 <CACRpkdZ-QpHzeEBO=RFVe-8S2DG4-thhwW9iVbAMXZrOe-FnAw@mail.gmail.com>
Message-ID: <201209101013.16697.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 September 2012, Linus Walleij wrote:
> Basically that was at a point when we were changing a lot of
> subsystem trees with DT patches that were merged in out-of-order
> fashion.
> 
> Then it's better to have the DT changes to be pushed
> separately at the end of the merge window after all subtrees
> with dependent changes are merged. (Or even in the next merge
> window if there is no hurry, but we always seem to be in a hurry...)
> 
> If all the changes are in the same subtree (like ARM SoC with
> ACKs from all over the place where needed) you can do it
> this way instead, and I agree it looks better.

I think we're talking about different things:

I think it's fine to do the device driver conversion separately
from the platform changes, but doing that properly means that the
platform changes should only go in after the drivers have changed.

Inside of the platform code, I absolutely think we should change the
board file and the dts file simultaneously. When the driver offers
two ways of probing a device, this lets us change from one way to
the other without going through a phase where we use neither of them
or (worse) both at the same time.

	Arnd
