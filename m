From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 17:02:34 +0200
Subject: [GIT PULL 1/2] SOCFPGA updates for 3.18
In-Reply-To: <20140909141756.GA30100@amd>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
 <20140909141756.GA30100@amd>
Message-ID: <4134101.OOENTRabu1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 16:17:56 Pavel Machek wrote:
> > Jaehoon Chung (1):
> >       ARM: dts: socfpga: unuse the slot-node and deprecate the supports-highspeed for dw-mmc
> > 
> 
> This patch is a bad idea. It removes support for two mmc cards on a
> single controller -- configuration hardware supports and configuration
> that allows using u-SD card on mcvevk board.
> 

Your objection comes too late, and to the wrong patch, since the
driver and all other users have already been changed. We had a long
discussion about this when the issue first came up, and we could
not find any example of dw-mmc actually being used in a scenario
with one controller that has multiple devices attached.

Apparently every user out there instead uses multiple controller
instances instead. Are you sure that the socfpga implementation
is an exception from this?

	Arnd
