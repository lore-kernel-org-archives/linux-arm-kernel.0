From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Nov 2009 20:59:10 +0000
Subject: NAND: failure reported with mtd_oobtest(read delay violated)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA5CC012@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA5CC012@dbde02.ent.ti.com>
Message-ID: <20091112205910.GB11304@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 09:28:58PM +0530, Govindarajan, Sriramakrishnan wrote:
> OMAP3EVM implementation relies on command delay(chip_delay set to 50ms)
> and doesn't use wait pin monitoring. By adding a data memory barrier
> dmb() instruction right after the command phase the issue seems to be
> resolved.

Clearly adding ARM specific calls into generic code is the wrong thing
to do...  Why can't this dmb() go into whatever NAND driver OMAP is using?
