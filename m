From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Apr 2018 18:31:06 +0100
Subject: [PATCH v2 1/2] regmap: include <linux/ktime.h> from
 include/linux/regmap.h
In-Reply-To: <f4025431-be9a-32f9-06e1-9c6ac185c96a@gmail.com>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
 <20180423100318.GA19834@sirena.org.uk>
 <d3e10dc5-55d3-40b8-a8de-d48aaaecf019@gmail.com>
 <20180423115043.GD19834@sirena.org.uk>
 <f4025431-be9a-32f9-06e1-9c6ac185c96a@gmail.com>
Message-ID: <20180424173106.GE22073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 04:07:10PM +0200, Matthias Brugger wrote:
> On 04/23/2018 01:50 PM, Mark Brown wrote:

> > So it looks like there is a dependency here...?

> Yes, regmap_read_poll_timeout macro uses for example ktime_compare which is
> defined in linux/ktime.h

> That's my understanding.

OK, it's important to make sure that people getting a patch series know
about stuff like this as it will affect how things are reviewed and
applied.  

The following changes since commit e241e3f2bf975788a1b70dff2eb5180ca395b28e:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2018-04-11 18:58:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-ktime-fix

for you to fetch changes up to f15cd6d99198e9c15229aefec639a34a6e8174c6:

  regmap: include <linux/ktime.h> from include/linux/regmap.h (2018-04-24 18:11:50 +0100)

----------------------------------------------------------------
regmap: Fix missing include of ktime.h

Required for some dependencies.

----------------------------------------------------------------
Sean Wang (1):
      regmap: include <linux/ktime.h> from include/linux/regmap.h

 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/738b2a74/attachment.sig>
