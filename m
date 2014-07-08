From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Tue,  8 Jul 2014 18:54:26 +0300
Subject: [PATCH 0/3] Support for Qualcomm QPNP PMIC's
Message-ID: <1404834869-23049-1-git-send-email-svarbanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello to all,

Here is patch set which adds Qualcomm QPNP PMIC's support.
I've removed RFC tag and sending as regular set hoping that
this time more comments will come out. The link to the RFCv2
at [1].

The first patch in the set implements an *of* based parsing of
PMIC peripheral resources and adding mfd cell for it.
The devicetree node should contain a compatible and reg
proparties. The intention was to keep things simple and similar
to the other mfd drivers. 

The second patch adds binding document for qpnp-spmi.

The third patch describes the devicetree binding of the slave
devices attached to the SPMI interface. 

Comments are welcome.

regards,
Stan

[1] https://lkml.org/lkml/2014/7/3/443

Ivan T. Ivanov (2):
  mfd: qpnp-spmi: document DT bindings for Qualcomm QPNP PMICs
  dt: qcom: msm8974: add qpnp-spmi device nodes

Josh Cartwright (1):
  mfd: qpnp-spmi: add support for Qualcomm QPNP PMICs

 .../devicetree/bindings/qpnp/qcom,qpnp-spmi.txt    |   53 +++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   45 ++++++
 drivers/mfd/Kconfig                                |   15 ++
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/qpnp-spmi.c                            |  145 ++++++++++++++++++++
 5 files changed, 259 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/qpnp/qcom,qpnp-spmi.txt
 create mode 100644 drivers/mfd/qpnp-spmi.c
