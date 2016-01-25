From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Mon, 25 Jan 2016 10:46:28 +0100
Subject: [PATCH v4 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <1453675703-31594-2-git-send-email-marcel.ziswiler@toradex.com>
References: <1453675703-31594-1-git-send-email-marcel.ziswiler@toradex.com>
 <1453675703-31594-2-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20160125094628.GH27359@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marcel Ziswiler <marcel.ziswiler@toradex.com> [2016-01-24 23:48:22]:

Hi Marcel,

sorry for not commenting on your v3, I've missed it :(

> +	regulators {
> +		compatible = "simple-bus";
> +

I've commented this on your v2 already. One of the Lucas's comments[1] about
this node was following:

    "Get rid of this simple bus. It's not there in hardware and regulators
    care board level components just like the nodes above and below."

It works for me(tm) with following Apalis dtsi[2] on 4.4.0-rc3+ from
arm-soc/for-next[3] with my changes based on this commit:

    commit ce504c3d47508fd5590bc9b644e4318a2b5b9aa5
    Author: Olof Johansson <olof@lixom.net>
    Date:   Tue Jan 12 10:29:35 2016 -0800

        ARM: SoC: document merges

    root at OpenWrt:/# uname -a
    Linux OpenWrt 4.4.0-rc3+ #121 SMP Mon Jan 25 10:06:14 CET 2016 armv7l GNU/Linux

    root at OpenWrt:/# cat /proc/device-tree/model
    Toradex Apalis iMX6Q/D on Gaben Flexi SBC

    root at OpenWrt:/# cat /sys/kernel/debug/regulator/regulator_summary
     regulator                      use open bypass voltage current     min     max
    -------------------------------------------------------------------------------
     regulator-dummy                  0    2      0     0mV     0mA     0mV     0mV 
        2188000.ethernet                                                0mV     0mV
        2090000.flexcan                                                 0mV     0mV
     vdd1p1                           0    0      0  1100mV     0mA   800mV  1375mV 
     vdd3p0                           0    0      0  3000mV     0mA  2800mV  3150mV 
     vdd2p5                           0    0      0  2400mV     0mA  2000mV  2750mV 
     vddarm                           0    1      0  1250mV     0mA   725mV  1450mV 
        cpu0                                                         1250mV  1250mV
     vddpu                            1    2      0  1250mV     0mA   725mV  1450mV 
        cpu0                                                         1250mV  1250mV
        20dc000.gpc                                                     0mV     0mV
     vddsoc                           0    1      0  1250mV     0mA   725mV  1450mV 
        cpu0                                                         1250mV  1250mV
     1P8V                             0    0      0  1800mV     0mA  1800mV  1800mV 
     2P5V                             0    0      0  2500mV     0mA  2500mV  2500mV 
     3P3V                             0    2      0  3300mV     0mA  3300mV  3300mV 
        2198000.usdhc                                                3300mV  3400mV
        2194000.usdhc                                                3300mV  3400mV
     usb_host_vbus_hub                1    1      0  5000mV     0mA  5000mV  5000mV 
        usb_host_vbus                 1    1      0  5000mV     0mA  5000mV  5000mV 
           2184200.usb                                                  0mV     0mV
     usb_otg_vbus                     0    1      0  5000mV     0mA  5000mV  5000mV 
        2184000.usb                                                     0mV     0mV
     SW1AB                            0    0      0  1375mV     0mA   300mV  1875mV 
     SW1C                             0    0      0  1375mV     0mA   300mV  1875mV 
     SW2                              0    0      0  1000mV     0mA     0mV     0mV 
     SW3A                             0    0      0  1500mV     0mA   400mV  1975mV 
     SW3B                             0    0      0  1500mV     0mA     0mV     0mV 
     SW4                              0    0      0  1000mV     0mA     0mV     0mV 
     SWBST                            0    0      0  5000mV     0mA  5000mV  5150mV 
     VSNVS                            0    0      0  3000mV     0mA  1000mV  3000mV 
     VREFDDR                          0    0      0   750mV     0mA   750mV   750mV 
     VGEN1                            0    0      0  1500mV     0mA   800mV  1550mV 
     VGEN2                            0    0      0  1500mV     0mA   800mV  1550mV 
     VGEN3                            0    0      0  3000mV     0mA  1800mV  3300mV 
     VGEN4                            0    0      0  1800mV     0mA  1800mV  3300mV 
     VGEN5                            0    0      0  2500mV     0mA  1800mV  3300mV 
     VGEN6                            0    0      0  2800mV     0mA  1800mV  3300mV 

What problems are you having if you remove that parent regulators node?

1. http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386456.html
2. https://raw.githubusercontent.com/ynezz/linux-2.6/5a211784544a3a460df7e7e45479010ae3feaf76/arch/arm/boot/dts/imx6qdl-apalis.dtsi
3. git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc

Thanks for your work!

-- ynezz
