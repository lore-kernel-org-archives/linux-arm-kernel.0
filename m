From: christer@weinigel.se (Christer Weinigel)
Date: Tue, 08 Jun 2010 14:50:55 +0200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100608115832.GB25370@n2100.arm.linux.org.uk>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>	<4C083BCF.2060500@bluewatersys.com>	<201006040310.15019.marek.vasut@gmail.com>	<4C0853E1.1080005@bluewatersys.com>	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>	<20100604061034.GI6499@atomide.com>	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
	<20100608115832.GB25370@n2100.arm.linux.org.uk>
Message-ID: <4C0E3CAF.4050409@weinigel.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2010 01:58 PM, Russell King - ARM Linux wrote:

> If you're hypothesis that Linus is only looking at the diffstat, then
> what are patches to combine the defconfigs going to do?  It's going
> to create lots of noise in arch/arm/configs/ - which is precisely what
> Linus is complaining about.  In fact, patch-wise it's going to create
> an extremely large patch.  And if we do this time and time again while
> progressively reducing the defconfigs.  No, this isn't the answer -
> it's only going to make the problem worse.


Linus isn't stupid.  If you explain what you are doing and that the goal 
is to reduce the set of defconfigs to just one per processor family, and 
that it will reduce the churn in the end, I think Linus will listen.

Actually, why not just ask Linus if the the way Ben Dooks has structured 
the Samsung defconfigs would be ok with him.  It's only one defconfig 
per CPU family and each defconfig supports a lot of boards.
s3c2410_defconfig supports most ARM9 based Samsung SoCs, S3C2410, 
S3C2412, S3C2413, S3C2440 and S3C2442, all in all some 20-odd boards. 
So for someone who wants to start a new S3C port they can just use the 
s3c2410_defconfig as a base, which I think is how Linus want's the 
defconfigs to be used.

   /Christer
