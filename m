From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu, 30 May 2013 19:50:24 +0200
Subject: [PATCHv3 RESEND 0/6] ARM: sunxi: Add support for A10 Ethernet
 controller
In-Reply-To: <20130530081129.GF9799@lukather>
References: <1369387394-9453-1-git-send-email-maxime.ripard@free-electrons.com>
 <CACQ1gAgp6o8HqQcv=4cWoAZze3wtXHMX+g+7KvV-pnC2W5=iyg@mail.gmail.com>
 <20130530081129.GF9799@lukather>
Message-ID: <CACQ1gAhu0P0BvfNkhsSgdzeU7Pf+CxesVJ87ok2FMpfBmaRMXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/30 Maxime Ripard <maxime.ripard@free-electrons.com>:
>
> Did you look at the load while iperf was running? I guess we can expect
> it to be pretty high since it runs without DMA.

I just did the test.
cpu is at 55%-60%

root at debian:~# date ; iperf -c 192.168.1.10 -t 300 ; cat /proc/loadavg
Thu May 30 17:43:13 UTC 2013
------------------------------------------------------------
Client connecting to 192.168.1.10, TCP port 5001
TCP window size: 20.0 KByte (default)
------------------------------------------------------------
[  3] local 192.168.1.235 port 45459 connected with 192.168.1.10 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-300.0 sec  3.28 GBytes  94.0 Mbits/sec
0.83 0.71 0.43 1/46 1770

loadavg over a 5min at 0.71, yeah, that's pretty high...

Richard.
