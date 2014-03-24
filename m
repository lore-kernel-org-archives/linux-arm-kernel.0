From: marex@denx.de (Marek Vasut)
Date: Mon, 24 Mar 2014 21:21:58 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
References: <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <OF42C103CA.1A3B5524-ON87257CA5.005C7764-87257CA5.0062A13A@grpleg.it>
Message-ID: <201403242121.58705.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 24, 2014 at 06:57:18 PM, robert.daniels at vantagecontrols.com 
wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote on 03/21/2014
> 
> 11:32:53 AM:
> > Hmm, rt kernels.  Does this happen without the rt patches applied?
> 
> I am not using the rt patches and I still see the problem.  I'm using
> 3.14.0-rc6+ with
> fec patches on the i.MX53 Quick Start Board with the latest U-Boot.
> 
> When I run my test I will immediately see packet loss with the eventual tx
> timeout issue.
> 
> These are the steps I use to reproduce the problem:
> 
> Setup: Desktop (Ubuntu 12.04: webfs, iperf3, /srv/ftp/test.bmp ~27 MB)
>        i.MX53 Quick Start Board (linux 3.14.0-rc6+ with fec patches:
> iperf3, wget)
> 
> Test:
> 
>   Desktop:
>     iperf3 -s -V
> 
>   i.MX53 QSB:
>     ssh 1> iperf3 -c 192.168.1.101 -u -l 64 -b 55M -V -t 1000

I think the UDP test might be lossy, can you try with TCP test please ?

Best regards,
Marek Vasut
