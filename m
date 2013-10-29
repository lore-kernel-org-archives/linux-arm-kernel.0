From: leigh@solinno.co.uk (Leigh Brown)
Date: Tue, 29 Oct 2013 09:33:30 +0000
Subject: [PATCH v3 0/4] Fix MDIO bus timeout issues on Dreamplug
In-Reply-To: <cover.1382637156.git.leigh@solinno.co.uk>
References: <cover.1382637156.git.leigh@solinno.co.uk>
Message-ID: <cover.1383038973.git.leigh@solinno.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think I have addressed all comments.

Changes since v2:
 - Fix coding style in ordio_mdio_wait_ready, as identified by David
 - Remove un-needed operator change in orion_mdio_write, as identified by David

This patchset fixes an issue with the Dreamplug MDIO bus timeout since the
mv643xx_eth driver was converted to use the mvmdio driver to access the bus.

Leigh Brown (4):
  net: mvmdio: make orion_mdio_wait_ready consistent
  net: mvmdio: orion_mdio_ready: remove manual poll
  net: mvmdio: slight optimisation of orion_mdio_write
  net: mvmdio: doc: mvmdio now used by mv643xx_eth

 drivers/net/ethernet/marvell/mvmdio.c | 110 ++++++++++++++++------------------
 1 file changed, 53 insertions(+), 57 deletions(-)

-- 
1.8.4.rc3
