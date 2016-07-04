From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jul 2016 14:35:25 +0200
Subject: next-20160704 build: 2 failures 7 warnings (next-20160704)
In-Reply-To: <E1bK2Ok-0002jU-NX@optimist>
References: <E1bK2Ok-0002jU-NX@optimist>
Message-ID: <20160704123525.GA6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 12:50:46PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/gpu/drm/sti/sti_hdmi.c:1250:15: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../drivers/gpu/drm/sti/sti_hdmi.c:1251:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../drivers/gpu/drm/sti/sti_hdmi.c:1252:18: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> ../drivers/gpu/drm/sti/sti_hdmi.c:1253:13: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]

due to adding new code which doesn't take account of the recent API
change in the HDMI CODEC.  There's another change already in DRM for
which the expectation was that the API change and an update Arnd posted
would be pulled over so I guess the same approach makes sense here:

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-hdmi-codec-pdata

for you to fetch changes up to efc9194bcff84666832c6493bafa92029ac6634c:

  ASoC: hdmi-codec: callback function will be called with private data (2016-06-27 18:53:15 +0100)

----------------------------------------------------------------
ASoC: Add private data for HDMI CODEC callbacks

Allow the HDMI CODECs to get private data passed in in callbacks.

----------------------------------------------------------------
Kuninori Morimoto (1):
      ASoC: hdmi-codec: callback function will be called with private data

 include/sound/hdmi-codec.h    | 13 ++++++++-----
 sound/soc/codecs/hdmi-codec.c | 15 ++++++++-------
 2 files changed, 16 insertions(+), 12 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160704/e022128a/attachment-0001.sig>
