From: sebastian.reichel@collabora.com (Sebastian Reichel)
Date: Sun, 16 Sep 2018 22:43:23 +0200
Subject: [PATCH 0/6] shutdown procedure verification for SAMA5D2
In-Reply-To: <20180916104301.dcrm333ydo5kh5bj@earth.universe>
References: <1535629811-13403-1-git-send-email-claudiu.beznea@microchip.com>
 <20180916104301.dcrm333ydo5kh5bj@earth.universe>
Message-ID: <20180916204323.ysvt4axagxyx7hsc@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Sun, Sep 16, 2018 at 12:43:01PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Aug 30, 2018 at 02:50:05PM +0300, Claudiu Beznea wrote:
> > Hi,
> > 
> > Patch 1 from this series implement a fix for shutdown procedure
> > for SAMA5D2.
> > 
> > The rest of the patch are improvements as follows:
> > patch 2 - use only one function for poweroff
> > patches 3-6 - cosmetic improvements
> > 
> > The patches are based on latest sys-reset/for-next [1].
> > 
> > Thank you,
> > Claudiu Beznea
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
> 
> Thanks, queued.

I merged this via a immutable branch, that you can pull into at91 or
ignore:

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/psy-at91-poweroff-immutable-for-v4.20-signed

for you to fetch changes up to 9f1e44774be578fb92776add95f1fcaf8284d692:

  power: reset: at91-poweroff: do not procede if at91_shdwc is allocated (2018-09-16 12:32:17 +0200)

----------------------------------------------------------------
Immutable branch for mach-at91 and power-supply for v4.20

Immutable branch between mach-at91 and power-supply for driver
changes in at91-poweroff.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

----------------------------------------------------------------
Claudiu Beznea (6):
      power: reset: at91-poweroff: switch to slow clock before shutdown
      power: reset: at91-poweroff: use only one poweroff function
      power: reset: at91-poweroff: make mpddrc_base part of struct shdwc
      power: reset: at91-poweroff: make sclk part of struct shdwc
      power: reset: at91-poweroff: rename at91_shdwc_base member of struct shdwc
      power: reset: at91-poweroff: do not procede if at91_shdwc is allocated

 arch/arm/mach-at91/pm_suspend.S          |   8 +++
 drivers/power/reset/at91-sama5d2_shdwc.c | 119 +++++++++++++++++++++----------
 2 files changed, 88 insertions(+), 39 deletions(-)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180916/1a41f556/attachment.sig>
