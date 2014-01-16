From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jan 2014 18:22:12 +0000
Subject: [PATCH 0/2] DT updates for Hummingboard and new Cubox-i
Message-ID: <20140116182211.GX15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the Cubox-i has been released, and I have one, I've been able to
update things a little.  Out of the following two patches, the first one
I think is critical to be merged before the microsom support hits
mainline, since it drops the flexcan support from the microsom level,
moving it to the Hummingboard level.

That doesn't have _too_ much visible effect, but it's something which
should not be there (since as far as the microsom is concerned, there's
nothing special about these pads.)

The second adds basic support for the Cubox-i - as I have only the i4,
this is the platform which this has been tested against, but I've
generated the solo/dual-lite version as well since the only difference
at this basic level is the eSATA.

 arch/arm/boot/dts/Makefile                |  2 +
 arch/arm/boot/dts/imx6dl-cubox-i.dts      | 12 +++++
 arch/arm/boot/dts/imx6dl-hummingboard.dts | 13 ++++++
 arch/arm/boot/dts/imx6q-cubox-i.dts       | 16 +++++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi    | 78 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-microsom.dtsi   | 13 ------
 6 files changed, 121 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-cubox-i.dts
 create mode 100644 arch/arm/boot/dts/imx6q-cubox-i.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
