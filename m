From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 16 Jan 2017 18:08:30 +0100
Subject: [PATCH v2 net-next 0/2] mvneta xmit_more and bql support
Message-ID: <1484586512-16412-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a delayed v2 of short patchset, which introduces xmit_more and BQL
to mvneta driver. The only one change was added in xmit_more support -
condition check preventing excessive descriptors concatenation before
flushing in HW.

Any comments or feedback would be welcome.

Best regards,
Marcin

Changelog:
v1 -> v2:

* Add checking condition that ensures too much descriptors are not
  concatenated before flushing in HW.

Marcin Wojtas (1):
  net: mvneta: add BQL support

Simon Guinot (1):
  net: mvneta: add xmit_more support

 drivers/net/ethernet/marvell/mvneta.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

-- 
1.8.3.1
