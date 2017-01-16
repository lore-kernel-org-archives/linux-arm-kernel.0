From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 17 Jan 2017 00:26:46 +0100
Subject: [PATCH v3 0/2] ARM: at91: properly handle LPDDR poweroff
In-Reply-To: <20161025093759.20913-1-alexandre.belloni@free-electrons.com>
References: <20161025093759.20913-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170116232646.ivoh5dhr56j4ihgp@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Tue, Oct 25, 2016 at 11:37:57AM +0200, Alexandre Belloni wrote:
> This patch set improves LPDDR support on SoCs using the Atmel MPDDR controller.
> 
> LPDDR memories can only handle up to 400 uncontrolled power offs in their
> life. The proper power off sequence has to be applied before shutting down the
> SoC.
> 
> I'm not too happy with the code duplication but this is a design choice
> that has been made before because both shutdown controllers are really
> different apart from the shutdown itself.
> 
> I guess it is still better than slowly killing the LPDDR.

Sorry, I totally forgot about this one. I queued it into my for-next
branch using an immutable topic branch, in case you need the patch
against the arm include to also go through arm-soc. Feel free to use
or ignore it:

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/ib-psy-arm-at91-4.11

for you to fetch changes up to 0b0408745e7ff24757cbfd571d69026c0ddb803c:

  power: reset: at91-poweroff: timely shutdown LPDDR memories (2017-01-16 23:21:33 +0100)

----------------------------------------------------------------
immutable branch between ARM at91 and power-supply for v4.11
----------------------------------------------------------------

Alexandre Belloni (2):
      ARM: at91: define LPDDR types
      power: reset: at91-poweroff: timely shutdown LPDDR memories

 drivers/power/reset/Kconfig              |  2 +-
 drivers/power/reset/at91-poweroff.c      | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/power/reset/at91-sama5d2_shdwc.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/soc/at91/at91sam9_ddrsdr.h       |  3 +++
 4 files changed, 105 insertions(+), 3 deletions(-)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/b06d0fb1/attachment.sig>
