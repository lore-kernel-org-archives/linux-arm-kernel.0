From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Mar 2015 16:42:49 -0700
Subject: [PATCH 0/6] mtd: teach mxc-nand about ONFI probing
In-Reply-To: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150311234249.GE32500@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 07:59:54PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this series implements support for ONFI probing in mxc-nand.
> Before a PARAM command was just ignored and the following read_bytes
> read whatever then happened to be available from the controller's RAM.
> But actually this wasn't that bad because the driver already failed to
> read the ONFI marker at offset 32 in response to the READID command and
> so the PARAM command wasn't issued at all :-)
> 
> Patch 1 is a robustness fix. Patch 2 is necessary to not make the
> controller stuck when the READPAGE command is issued before the flash
> chip is identified. Patch 3 is needed to be able to read more than 6
> bytes in the read_byte callback. Finally patch 4 fixes the driver to
> allow reading out the READID ONFI marker and patch 5 implements support
> for the PARAM command.
> 
> Patch 6 implements a WARN that triggers when the core requests an
> unknown command from the driver. In the case of missing PARAM support it
> wouldn't have triggered because READID at offset 0x20 failed, too, but
> it might be worthwhile anyhow; I'm not sure though, so I marked it RFC.
> Not sure the set of commands will grow in the near future ...
> 
> Best regards
> Uwe

Looks OK to me. Pushed all to l2-mtd.git.

Brian
