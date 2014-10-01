From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  1 Oct 2014 10:05:55 +0100
Subject: [PATCH v3 0/4] ARM: dts: apq8064 DT patches
In-Reply-To: <1412086159-20894-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1412086159-20894-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1412154355-2639-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches adds dt nodes for RPM, USB and SATA IPs found in APQ8064.
All the driver support for these IPs are already available in v3.17, except
the RPM driver which is now accepted by Lee and Mark.

These patches depend on the header file from 
http://www.spinics.net/lists/arm-kernel/msg364310.html
for regulators.

Now that the RPM patch is accepted, should RPM patch go via arm-soc tree?
so that we can get more functionality on IFC6410 board in v3.18 mainline.

All these patches are tested on IFC6410 board.
Am hoping to get these patches for v3.18, as these patches were sitting in
my dev tree since last 3 merge windows.


Changes since v2:
	- Bjorn added 4 missing MVS regulators.
	- fixed few compatible strings spotted by Bjorn.
	- Moved the voltage specifics to dts file as discussed with Bjorn.

Changes since v1:
	- Updated with all the regulators in the rpm as suggested by Bjorn.
	- Fixed few indentations spotted by both Bjorn, Stephen and others.
	

Thanks,
srini


Srinivas Kandagatla (4):
  ARM: dts: apq8064: add RPM regulators support
  ARM: dts: apq8064: Add usb host support.
  ARM: dts: apq8064: Add USB OTG support
  ARM: dts: apq8064: Add SATA controller support.

 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |  77 +++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 355 +++++++++++++++++++++++++++++
 2 files changed, 432 insertions(+)

-- 
1.9.1
