From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Sat, 15 Oct 2016 10:46:11 +0200
Subject: Low network throughput on i.MX28
In-Reply-To: <20161014081349.1afb22c6@ipc1.ka-ro>
References: <1476313753.2065.11.camel@embedded.rocks>
 <20161013084807.6a231fdb@ipc1.ka-ro>
 <A57BCA39-0977-43C4-B22D-ED60F5E4B06D@embedded.rocks>
 <20161014081349.1afb22c6@ipc1.ka-ro>
Message-ID: <1476521171.1670.2.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-10-14 at 08:13 +0200, Lothar Wa?mann wrote:
> Hi,
> 
> On Thu, 13 Oct 2016 21:43:00 +0200 J?rg Krause wrote:
> > Am 13. Oktober 2016 08:48:07 MESZ, schrieb "Lothar Wa?mann" <LW@KAR
> > O-electronics.de>:
> > > On Thu, 13 Oct 2016 01:09:13 +0200 J?rg Krause wrote:
> 
> [...]
> > > This is the iperf output on a TX28 with current mainline kernel
> > > (4.8.0-rc5):
> > > ------------------------------------------------------------
> > > Client connecting to 192.168.100.1, TCP port 5001
> > > TCP window size: 43.8 KByte (default)
> > > ------------------------------------------------------------
> > > [??3] local 192.168.100.56 port 60325 connected with
> > > 192.168.100.1 port
> > > 5001
> > > [ ID] Interval???????Transfer?????Bandwidth
> > > [??3]??0.0-10.0 sec??57.5 MBytes??48.2 Mbits/sec
> > > 
> > > You might check your kernel DEBUG configs (especially
> > > CONFIG_DEBUG_PAGEALLOC).
> > 
> > Thanks for sharing the iperf output. What LAN transceiver does the
> > TX28 has assembled?
> > 
> 
> The ethernet PHY is an SMSC LAN8710A.

Thanks!


For the record:

Note, this is the result for the wireless interface.

I got one of my custom boards running the legacy Linux Kernel 2.6.35
officially supported from Freescale (NXP) and the bcmdhd driver from
the Wiced project, where I get >20Mbps TCP throughput. The firmware
version reported is:

# wl ver
5.90 RC115.2
wl0: Apr 24 2014 14:08:41 version 5.90.195.89.24 FWID 01-bc2d0891


I got it also running with the Linux Kernel 4.1.15 from Freescale [2],
which is not officially supported for the i.MX28 target, with the
latest bcmdhd version where I get <7Mbps TCP throughput (which is much
the same I get with the brcmfmac driver). The firmware version reported
is:

# wl ver
1.107 RC5.0
wl0: Aug??8 2016 02:17:48 version 5.90.232 FWID 01-0

So, probably something is missing in the newer Kernel version, which is
present in the legacy Kernel 2.6.35.

[1] http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=
imx_2.6.35_1.1.0
[2] http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=
imx_4.1.15_1.0.0_ga
