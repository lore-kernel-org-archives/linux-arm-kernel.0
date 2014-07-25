From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Jul 2014 18:43:11 +0100
Subject: [PATCH v2 01/16] regmap: Add regmap_get_device
In-Reply-To: <1405957142-19416-2-git-send-email-ttynkkynen@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-2-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20140725174311.GA17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 06:38:47PM +0300, Tuomas Tynkkynen wrote:
> Add a new function regmap_get_device to obtain the underlying struct
> device from a regmap.

I've also created a signed tag for use in other trees:

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/getdev

for you to fetch changes up to fa2fbe4a981a70866d20cee62af0d89eb6b6027e:

  regmap: Allow regmap_get_device() to be used by modules (2014-07-25 18:30:31 +0100)

----------------------------------------------------------------
regmap: Support for retrieving the struct device for a regmap

Some hardware has support for regmap style operations, this is
especially common with embedded controllers that interact with PMICs.
Allow drivers handling such devices to get the device from a regmap to
aid in supporting such functionality.

Signed-off-by: Mark Brown <broonie@linaro.org>

----------------------------------------------------------------
Mark Brown (1):
      regmap: Allow regmap_get_device() to be used by modules

Tuomas Tynkkynen (1):
      regmap: Add regmap_get_device

 drivers/base/regmap/regmap.c | 13 +++++++++++++
 include/linux/regmap.h       |  7 +++++++
 2 files changed, 20 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/3015bac8/attachment.sig>
