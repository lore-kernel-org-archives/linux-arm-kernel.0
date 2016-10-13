From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 13 Oct 2016 08:48:07 +0200
Subject: Low network throughput on i.MX28
In-Reply-To: <1476313753.2065.11.camel@embedded.rocks>
References: <1476313753.2065.11.camel@embedded.rocks>
Message-ID: <20161013084807.6a231fdb@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 13 Oct 2016 01:09:13 +0200 J?rg Krause wrote:
> Hi,
> 
> I am using a custom i.MX28 board similar to the i.MX28-EVK. For Wi-Fi
> the board assembles a BCM43362 from Broadcom and for Ethernet a
> LAN8720A from Microchip. The board is running mainline Linux 4.7.
> 
> While both, wireless and wired network interfaces work, the TCP
> throughput measured with iperf is low.
> 
> The bandwith for Ethernet is between 20-30 MBits/sec and for WLAN is
> about 4-5 MBits/sec.
> 
> There exists an Application Note "i.MX28 Ethernet Performance on
> Linux" [1] which shows a bandwith of > 60 MBits/sec. A user an the NXP
> forum [2] told he achieved 20 MBits/sec with some Qualcom chip.
> 
> Note, that these values are most probably measured with the legacy
> Linux Kernel 2.6.35 from NXP.
> 
> Does anybody has done throughput tests on i.MX28 with mainline Kernel?
> If so, what are the results? What might be the bottleneck?
>

This is the iperf output on a TX28 with current mainline kernel
(4.8.0-rc5):
------------------------------------------------------------
Client connecting to 192.168.100.1, TCP port 5001
TCP window size: 43.8 KByte (default)
------------------------------------------------------------
[  3] local 192.168.100.56 port 60325 connected with 192.168.100.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec  57.5 MBytes  48.2 Mbits/sec

You might check your kernel DEBUG configs (especially
CONFIG_DEBUG_PAGEALLOC).


Lothar Wa?mann
