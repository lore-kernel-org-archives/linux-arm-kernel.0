From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 29 May 2013 19:16:07 +0800
Subject: [PATCH v4 4/4] ARM: dts: add initial VF610 Tower board dts support
In-Reply-To: <1369732343-2982-5-git-send-email-b35083@freescale.com>
References: <1369732343-2982-1-git-send-email-b35083@freescale.com>
 <1369732343-2982-5-git-send-email-b35083@freescale.com>
Message-ID: <20130529111605.GA25053@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 05:12:23PM +0800, Jingchang Lu wrote:
> +&fec0 {
> +	phy-mode = "rmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec0_1>;
> +	status = "okay";
> +};

I'm wondering if fec works fine on your side.  The kernel seems to halt
on the repeated phy messages below here when I boot the kernel with NFS.

Shawn

fec 400d0000.ethernet eth0: Freescale FEC PHY driver [Generic PHY]
(mii_bus:phy_addr=400d0000.etherne:00, irq=-1)
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
fec 400d1000.ethernet eth1: Freescale FEC PHY driver [Generic PHY]
(mii_bus:phy_addr=400d0000.etherne:01, irq=-1)
IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
libphy: 400d0000.etherne:00 - Link is Up - 100/Full
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
libphy: 400d0000.etherne:01 - Link is Up - 100/Full
IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.102
IP-Config: Complete:
     device=eth0, hwaddr=00:04:9f:02:19:38, ipaddr=192.168.1.102,
mask=255.255.255.0, gw=192.168.1.1
     host=192.168.1.102, domain=domain, nis-domain=(none)
     bootserver=0.0.0.0, rootserver=192.168.1.100, rootpath=, mtu=576
     nameserver0=61.177.7.1, nameserver1=221.228.255.1
ALSA device list:
  No soundcards found.
libphy: 400d0000.etherne:00 - Link is Up - 100/Half
libphy: 400d0000.etherne:00 - Link is Up - 100/Full
libphy: 400d0000.etherne:00 - Link is Up - 100/Half
libphy: 400d0000.etherne:00 - Link is Up - 100/Full
libphy: 400d0000.etherne:00 - Link is Up - 100/Half
libphy: 400d0000.etherne:00 - Link is Up - 100/Full
libphy: 400d0000.etherne:00 - Link is Up - 100/Half
...
