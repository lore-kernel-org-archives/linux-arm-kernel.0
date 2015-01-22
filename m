From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 21 Jan 2015 20:52:55 -0800
Subject: [PATCH V2 0/3] perf symbols: debuglink and arm mapping symbols changes
Message-ID: <1421902378-3634-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks,

Here is second version of mini-series that addresses couple issues
in perf symbols handling.

Changes since V1:

o 'perf symbols: Ignore mapping symbols on aarch64': based on feedback
from Will Deacon and Russell King [1] added code that handles ARM/Aarch64
mapping symbols like "$d.<any>". Code uses similar snipet to handle
ARM mapping symbols as in another places in kernel, but it has its
own version of the code. Added proper Acked-by.

o 'perf symbols: debuglink should take symfs option into account':
based on feedback from David Ahern [2] picked more simple version that
does not make malloced copy of 'filename', that makes patch simpler.
Added proper 'Acked-and-tested-by'.

[1] https://lkml.org/lkml/2015/1/13/507

[2] https://lkml.org/lkml/2015/1/13/508

Victor Kamensky (3):
  perf symbols: Ignore mapping symbols on aarch64
  perf symbols: improve abi compliance in arm mapping symbols handling
  perf symbols: debuglink should take symfs option into account

 tools/perf/util/dso.c        |  6 +++---
 tools/perf/util/symbol-elf.c | 13 ++++++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
1.9.3
