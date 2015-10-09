From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  9 Oct 2015 20:48:13 +0200
Subject: [GIT PULL 2/3] ARM: berlin: DT changes for v4.4 (round 1)
In-Reply-To: <1444416494-3117-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1444416494-3117-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1444416494-3117-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is round 1 of Marvell Berlin DT changes for v4.4. There is
some improvement in serial aliases/stdout path, cpufreq properties,
and PWM nodes for all SoCs. The cpufreq properties depend on cpuclk
being available, therefore this branch has a dependency with the
cpuclk topic PR sent earlier.

Please pull.

Sebastian

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-for-4.4-1

for you to fetch changes up to 5f5cdc08231eb802ad3890ba3bd2ef272c21b924:

  ARM: berlin: add a PWM node on the BG2CD (2015-10-05 20:09:26 +0200)

----------------------------------------------------------------
Marvell Berlin DT for 4.4 take 1
- use serial aliases and stdout path
- add cpufreq properties to all SoCs
- add pwm nodes for all SoCs

This depends on topic branch berlin-cpuclk-for-4.4-1

----------------------------------------------------------------
Antoine Tenart (6):
      ARM: berlin: dts: add the cpufreq-dt bindings on the BG2Q
      ARM: berlin: dts: add the cpufreq-dt bindings on the BG2
      ARM: berlin: dts: add the cpufreq-dt bindings on the BG2CD
      ARM: berlin: add a PWM node on the BG2Q
      ARM: berlin: add a PWM node on the BG2
      ARM: berlin: add a PWM node on the BG2CD

Jisheng Zhang (2):
      arm: dts: berlin: add aliases for serial
      arm: dts: berlin: use stdout-path

 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        |  3 ++-
 arch/arm/boot/dts/berlin2.dtsi                    | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts |  3 ++-
 arch/arm/boot/dts/berlin2cd.dtsi                  | 20 ++++++++++++++++++++
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts        |  3 ++-
 arch/arm/boot/dts/berlin2q.dtsi                   | 23 +++++++++++++++++++++++
 6 files changed, 72 insertions(+), 3 deletions(-)
