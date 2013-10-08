From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 07 Oct 2013 20:42:01 -0500
Subject: socfpga: DTS updates for v3.13
In-Reply-To: <1381184217-31249-1-git-send-email-dinguyen@altera.com>
References: <1381184217-31249-1-git-send-email-dinguyen@altera.com>
Message-ID: <525362E9.4020907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please ignore this message, I forgot to include the [GIT PULL] in the 
subject.

Sorry for any inconvenience. Let me re-send.

Dinh
On 10/7/13 5:16 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
>
> Hi Kevin, Olof, and Arnd:
>
> Please consider these DTS updates for the Altera SOCFPGA for v3.13:
>
> Five of the six patches do NOT have an Ack from the DTS maintainers. I have
> sent the patches out for review, but since these patches do not change
> bindings nor add new ones, I don't think they will get too much attention.
>
> Please advise if you think I need to wait for Ack(s) from them.
>
> Thanks,
>
> Dinh
>
> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
>
>    Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
>
> are available in the git repository at:
>
>    git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dts-updates-for-v3.13
>
> for you to fetch changes up to d28e284dbee1f81daef762faf980a2260c2c120e:
>
>    dts: socfpga: Add support for Altera's SOCFPGA Arria V board (2013-10-07 14:16:49 -0500)
>
> ----------------------------------------------------------------
> Updates to dts file structure for Altera's SOCFPGA
>
> * Does not include any new bindings or bindings change
> * Add dts file for a SOCFPGA with an Arria V FPGA
> * Add a clocks property for the TWD timer
> * Add support for Terasic SocKit Board which has Cyclone5 FPGA
> * From Steffen Trumtrar:
> "This series includes some minor cleanups (indentation and clock labels) and
> reorders the socfpga dts hierarchy from:
> 	socfpga.dtsi
> 	-> socfpga_$board.dts
> 	-> socfpga_$otherboard.dts
> to
> 	socfpga.dtsi
> 	-> socfpga_cyclone5.dtsi
> 	--> socfpga_cyclone5_$board.dts
> 	--> socfpga_cyclone5_$otherboard.dts
> "
>
> ----------------------------------------------------------------
> Dinh Nguyen (2):
>        arm: socfpga: Add clock for smp_twd timer
>        dts: socfpga: Add support for Altera's SOCFPGA Arria V board
>
> Steffen Trumtrar (4):
>        ARM: socfpga: dts: Move common nodes to cyclone5 dtsi
>        ARM: socfpga: dts: Add support for terasic SoCkit
>        ARM: socfpga: dts: cleanup indentation
>        ARM: socfpga: dts: fix s2f_* clock name
>
>   arch/arm/boot/dts/Makefile                         |    4 +-
>   arch/arm/boot/dts/socfpga.dtsi                     |  297 ++++++++++----------
>   arch/arm/boot/dts/socfpga_arria5.dtsi              |   58 ++++
>   arch/arm/boot/dts/socfpga_arria5_socdk.dts         |   40 +++
>   ...{socfpga_cyclone5.dts => socfpga_cyclone5.dtsi} |   20 --
>   arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |   40 +++
>   arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |   37 +++
>   7 files changed, 327 insertions(+), 169 deletions(-)
>   create mode 100644 arch/arm/boot/dts/socfpga_arria5.dtsi
>   create mode 100644 arch/arm/boot/dts/socfpga_arria5_socdk.dts
>   rename arch/arm/boot/dts/{socfpga_cyclone5.dts => socfpga_cyclone5.dtsi} (78%)
>   create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>   create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
>
