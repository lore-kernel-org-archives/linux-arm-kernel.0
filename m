From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Jul 2014 18:48:30 +0100
Subject: [PATCH v2 02/16] regulator: Add helpers for low-level register
 access
In-Reply-To: <1405957142-19416-3-git-send-email-ttynkkynen@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-3-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20140725174830.GB17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 06:38:48PM +0300, Tuomas Tynkkynen wrote:

> Add helper functions that allow regulator consumers to obtain low-level
> details about the regulator hardware, like the voltage selector register
> address and such. These details can be useful when configuring hardware
> or firmware that want to do low-level access to regulators, with no
> involvement from the kernel.

Applied, thanks.  I've also created a signed tag for this one:

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/getreg

for you to fetch changes up to 04eca28cde52cdf9eb91e127cc358ad79a8ec53b:

  regulator: Add helpers for low-level register access (2014-07-25 18:43:48 +0100)

----------------------------------------------------------------
regulator: Allow clients to retrieve voltage selection register
information

Some systems have embedded controllers that can automatically manage the
voltage of a regulator.  Help client drivers support this in a generic
fashion by providing access to the register information we have in the
framework.

----------------------------------------------------------------
Tuomas Tynkkynen (1):
      regulator: Add helpers for low-level register access

 Documentation/power/regulator/consumer.txt | 35 +++++++++++++++
 drivers/regulator/core.c                   | 71 ++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h         | 26 +++++++++++
 3 files changed, 132 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/aa0ac073/attachment.sig>
