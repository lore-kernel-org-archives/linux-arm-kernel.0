From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:52 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Bindings Updates for v4.15
Message-ID: <cover.1506676368.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT bindings updates for v4.15.


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-bindings-for-v4.15

for you to fetch changes up to 2e931b06de97d762ef139bffbbe75e1483735734:

  ARM: shmobile: remove inconsistent ; from documentation (2017-09-25 09:02:47 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC DT Bindings Updates for v4.15

* Consistently do not use ';' in documentation of compat strings
  for boards. A misture of using and not using a trailing ';' had
  krept in over time with not using being dominant.

* Document bindings for
  - Eagle board and r8a77970 (V3M) SoC bindings.
    Eagle is a board for the V3M SoC
  - Document Kingfisher board bindings.
    Kingfisher is an extension board for the H3ULCB and M3ULCB boards.

* Add r8a77970 (V3M) SYSC power domain definitions

  Add macros usable by the device tree sources to reference r8a77970 SYSC
  power domains by index.

* Add Renesas SoC DT bindings doc to Renesas ARM section of MAINTAINERS file

* Drop bogus node name suffix from example of /renesas,dw-hdmi binding

* Document APMU and SMP enable method for r8a7745 (RZ/G1E) SoC

----------------------------------------------------------------
Fabrizio Castro (1):
      dt-bindings: apmu: Document r8a7745 support

Geert Uytterhoeven (3):
      dt-bindings: display: renesas: dw-hdmi: Drop bogus node name suffix
      ARM: shmobile: Document R-Car V3M SoC DT bindings
      MAINTAINERS: Add Renesas SoC DT bindings doc to Renesas ARM sections

Sergei Shtylyov (2):
      dt-bindings: power: add R8A77970 SYSC power domain definitions
      arm64: renesas: document Eagle board bindings

Simon Horman (1):
      ARM: shmobile: remove inconsistent ; from documentation

Vladimir Barinov (1):
      arm: shmobile: Document Kingfisher board DT bindings

 Documentation/devicetree/bindings/arm/shmobile.txt | 16 +++++++----
 .../bindings/display/bridge/renesas,dw-hdmi.txt    |  2 +-
 .../devicetree/bindings/power/renesas,apmu.txt     |  1 +
 MAINTAINERS                                        |  2 ++
 include/dt-bindings/power/r8a77970-sysc.h          | 32 ++++++++++++++++++++++
 5 files changed, 47 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/power/r8a77970-sysc.h
