From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Aug 2014 12:05:54 +0100
Subject: [PATCH 1/2] regulator: core: Add
 REGULATOR_EVENT_PRE_VOLTAGE_CHANGE (and ABORT)
In-Reply-To: <1409254565-10677-2-git-send-email-dianders@chromium.org>
References: <1409254565-10677-1-git-send-email-dianders@chromium.org>
 <1409254565-10677-2-git-send-email-dianders@chromium.org>
Message-ID: <20140829110554.GN29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 12:36:04PM -0700, Doug Anderson wrote:
> From: Heiko St?bner <heiko@sntech.de>
> 
> In some cases we need to know when a regulator is about to be changed.
> Add a way for clients to be notified.  Note that for set_voltage() we
> don't necessarily know what voltage we'll end up with, so we tell the
> client what the range will be so they can prepare.

Applied, thanks.  I've created a tag for this, feel free to pull it into
any other tree that wants to use the feature:

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/voltage-ev

for you to fetch changes up to 7179569aeb52197fd2a9909ba226c4c9cc0e2e2a:

  regulator: core: Add REGULATOR_EVENT_PRE_VOLTAGE_CHANGE (and ABORT) (2014-08-29 11:58:31 +0100)

----------------------------------------------------------------
regulator: Add voltage event notifications

Allow users to synchronize before as well as after a volatge change.

----------------------------------------------------------------
Heiko St?bner (1):
      regulator: core: Add REGULATOR_EVENT_PRE_VOLTAGE_CHANGE (and ABORT)

 drivers/regulator/core.c           | 63 +++++++++++++++++++++++++++++++++-----
 include/linux/regulator/consumer.h | 20 ++++++++++++
 2 files changed, 76 insertions(+), 7 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/8d98edc2/attachment.sig>
