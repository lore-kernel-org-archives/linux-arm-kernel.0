From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 02 Nov 2014 21:51:45 +0100
Subject: [GIT PULL] pinctrl: rockchip: fixes and suspend support
Message-ID: <17258788.jyGObaPyvt@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

here is - as requested - a pull request of the sorted (and tested)
rockchip pinctrl patches from Doug and Chris.


Heiko


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.19-rockchip-pinctrl1

for you to fetch changes up to 8dca9331270240125fedbe83e0a2cd5750ed9fff:

  pinctrl: rockchip: save and restore gpio6_c6 pinmux in suspend/resume (2014-10-31 23:50:39 +0100)

----------------------------------------------------------------
Rockchip-pinctrl fixes from Doug Anderson and suspend-specific
functions from Chris Zhong

----------------------------------------------------------------
Chris Zhong (2):
      pinctrl: rockchip: add suspend/resume functions
      pinctrl: rockchip: save and restore gpio6_c6 pinmux in suspend/resume

Doug Anderson (4):
      pinctrl: rockchip: Set wake_enabled
      pinctrl: rockchip: Don't call pinctrl_gpio_direction_output() in pin_config_set()
      pinctrl: rockchip: Parse pin groups before calling pinctrl_register()
      pinctrl: rockchip: Protect read-modify-write with the spinlock

 drivers/pinctrl/pinctrl-rockchip.c | 116 ++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 22 deletions(-)
