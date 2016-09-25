From: mw@semihalf.com (Marcin Wojtas)
Date: Sun, 25 Sep 2016 09:47:52 +0200
Subject: [PATCH v4 0/1] Armada 7k/8k CP110 system controller fixes
Message-ID: <1474789673-3837-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Two patches from the third version of the patchset have already been
applied, so I re-send the last one with corrected allocation of
clock data, which was pointed in the review.

Any feedback would be very welcome.

Best regards,
Marcin

Changelog:
v4 <- v3
* fix allocation of clock data

v3 <- v2
* return -ENOMEM on alloc failures

v1 <- v2
* replace setting CLK_IS_BASIC flag with clearing init structure fields
  with memset
* minor improvements of allocation and error checking
* add migration to clk_hw


Marcin Wojtas (1):
  clk: mvebu: migrate CP110 system controller to clk_hw API and
    registration

 drivers/clk/mvebu/cp110-system-controller.c | 150 +++++++++++++---------------
 1 file changed, 72 insertions(+), 78 deletions(-)

-- 
1.8.3.1
