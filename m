From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Apr 2012 07:55:04 +0000
Subject: [PATCH] ARM: fix __io macro for PCMCIA
In-Reply-To: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
References: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
Message-ID: <201204040755.04517.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 April 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> With commit c334bc1 (ARM: make mach/io.h include optional), PCMCIA was
> broken as PCMCIA depends on __io() being just a cast. This needs a better
> fix with a fixed i/o address mapping, but for now we just restore things
> to the previous behavior.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Joachim Eastwood <joachim.eastwood@jotron.com>
> Cc: Paul Parsons <lost.distance@yahoo.com>

Yes, I suppose it's the only sane way for v3.4.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Russell, do you want to take it in your tree? Otherwise I'll put it into
arm-soc since that is where things broke.

	Arnd
