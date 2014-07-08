From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 8 Jul 2014 16:43:59 +0300
Subject: [GIT PULL 2/3] ARM: tegra: move fuse code out of arch/arm
In-Reply-To: <20140707004417.GE8469@quad.lixom.net>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <1403558626-13422-2-git-send-email-swarren@wwwdotorg.org>
 <20140707004417.GE8469@quad.lixom.net>
Message-ID: <20140708134359.GA23218@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 02:44:17AM +0200, Olof Johansson wrote:
> On Mon, Jun 23, 2014 at 03:23:45PM -0600, Stephen Warren wrote:
> > This branch moves code related to the Tegra fuses out of arch/arm and
> > into a centralized location which could be shared with ARM64. It also
> > adds support for reading the fuse data through sysfs.
> 
> The new/moved misc driver isn't acked by any misc maintainer, so I can't
> take this branch.
> 
> I saw no indication from searching the mailing list of that either,
> so it wasn't just a missed acked-by.
> 
> I wonder if this code should go under drivers/soc/ instead?

It's modelled after sunxi_sid.c which lives in drivers/misc/eeprom/.
Originally this driver was also in drivers/misc/eeprom/, but Stephen objected
and therefore it was moved to drivers/misc/fuse. I think that's the right
place still. We anyway need this driver for sata and xhci.

Cheers,

Peter.
