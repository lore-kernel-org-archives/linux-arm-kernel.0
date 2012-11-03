From: richardcochran@gmail.com (Richard Cochran)
Date: Sat,  3 Nov 2012 09:25:28 +0100
Subject: [PATCH net-next 0/2] cpsw: fix resource leak for v3.8
Message-ID: <cover.1351930782.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While looking at the idea of removing all of the register offsets in
the CPSW's device tree, I noticed that the driver would be leaking IO
mappings. Although this is, strictly speaking, a bug fix, still it can
wait to appear in v3.8, since there is no way to use the driver in
v3.7 (or earlier) anyhow.

Thanks,
Richard


Richard Cochran (2):
  cpsw: rename register banks to match the reference manual, part 2
  cpsw: fix leaking IO mappings

 drivers/net/ethernet/ti/cpsw.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)

-- 
1.7.2.5
