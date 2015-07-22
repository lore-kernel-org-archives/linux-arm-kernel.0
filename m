From: olof@lixom.net (Olof Johansson)
Date: Wed, 22 Jul 2015 16:10:20 -0700
Subject: [PATCH] memory: pl172: fix modular build
In-Reply-To: <1437603037-18395-1-git-send-email-manabian@gmail.com>
References: <20150722184345.GB11162@sirena.org.uk>
 <1437603037-18395-1-git-send-email-manabian@gmail.com>
Message-ID: <20150722231020.GA480@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 12:10:37AM +0200, Joachim Eastwood wrote:
> Building pl172 as a module fails with:
> > ERROR: "of_default_bus_match_table" [drivers/memory/pl172.ko] undefined!
> 
> Because the symbol of_default_bus_match_table isn't exported by the OF
> core code so can't be referenced from modules. Fix this by removing
> the usage of of_default_bus_match_table for now. The side effect of
> this is that child nodes can't use "simple-bus" or "simple-mfd".
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> 
> This should fix the allmod build failure introduces by the
> pl172 driver that Mark encountered. After this fix the driver
> should builds just fine as a module and there is no behavior
> change when boot my devkit either since none of children under
> pl172 uses "simple-bus/mfd" right now.

Thanks, applied.


-Olof
