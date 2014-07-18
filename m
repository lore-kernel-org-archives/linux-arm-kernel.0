From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Jul 2014 20:44:15 -0600
Subject: [GIT PULL 2/3] ARM: tegra: move fuse code out of arch/arm
In-Reply-To: <20140708134359.GA23218@tbergstrom-lnx.Nvidia.com>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <1403558626-13422-2-git-send-email-swarren@wwwdotorg.org>
 <20140707004417.GE8469@quad.lixom.net>
 <20140708134359.GA23218@tbergstrom-lnx.Nvidia.com>
Message-ID: <53C889FF.4070206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2014 07:43 AM, Peter De Schrijver wrote:
> On Mon, Jul 07, 2014 at 02:44:17AM +0200, Olof Johansson wrote:
>> On Mon, Jun 23, 2014 at 03:23:45PM -0600, Stephen Warren wrote:
>>> This branch moves code related to the Tegra fuses out of arch/arm and
>>> into a centralized location which could be shared with ARM64. It also
>>> adds support for reading the fuse data through sysfs.
>>
>> The new/moved misc driver isn't acked by any misc maintainer, so I can't
>> take this branch.
>>
>> I saw no indication from searching the mailing list of that either,
>> so it wasn't just a missed acked-by.
>>
>> I wonder if this code should go under drivers/soc/ instead?
> 
> It's modelled after sunxi_sid.c which lives in drivers/misc/eeprom/.
> Originally this driver was also in drivers/misc/eeprom/, but Stephen objected
> and therefore it was moved to drivers/misc/fuse. I think that's the right
> place still. We anyway need this driver for sata and xhci.

Sigh. This is exactly why (a) I suggested during that thread that the
driver should be in drivers/soc not drivers/misc and (b) I sent the pull
requests early enough so I could deal with any objections before my
vacation:-( I wish people would just respond to my review comments by
implementing them rather than persuading me to do the wrong thing. Since
this is all a dependency for pretty much everything for Tegra for 3.17,
I guess we should just drop all the Tegra pull requests for 3.17 and
we'll have to redo all the patches for 3.18:-( But if Thierry can (or
already has in another thread I haven't seen while on vacation) sort
this out be redoing all the Tegra branches, that might be fine too.
