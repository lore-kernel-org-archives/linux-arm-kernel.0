From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:10:36 +0100
Subject: big-endian patch series
Message-ID: <1377889856-9447-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the latest of the big-endian core updates for ARM. It is
currently pushed to the following location:

	git://git.baserock.org/delta/linux.git baserock/311-rc7/be/core-v2

It is now well reviewed and has been tested by a number of people
including Thomas Petazzoni and Victor Kamensky (who have both contributed
to getting this series sorted).

Russell, would this be something that you would accept a pull request for?
If so, can I leave the highbank, vexpress and mvebu in the series?

Changes since previous version:

- Updated patches reviewed by Dave Martin
- Fixed message in alignment trap handler (Sergei Shtylov)
- Fixed ordering in highbank (Rob Herring)
- Added Victor Kamensy's signal handling patch

There are a few small outstanding issues to deal with, but those are
not directly related to the functionality of this patch series. They
are as follows

- KGDB should be disbaled or fixed for THUMB kernels
- The kprobes test suite does not currently work with BE8 properly
- Modules may need 'be8' adding to the vermagic.
