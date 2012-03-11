From: gerg@snapgear.com (Greg Ungerer)
Date: Mon, 12 Mar 2012 09:48:33 +1000
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <m3aa3nqpxz.fsf@intrepid.localdomain>
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>	<201202281945.39419.arnd@arndb.de>	<alpine.LFD.2.02.1203052035170.31242@xanadu.home>	<201203061412.00073.arnd@arndb.de>	<alpine.LFD.2.02.1203061146210.31242@xanadu.home>	<CACRpkdYQpnSMVWUizEYHTjx_AK5Ai7dos0SBd208Wf5ZJLdrCw@mail.gmail.com>	<20120307091409.GL17370@n2100.arm.linux.org.uk>	<4F574C64.7010905@snapgear.com>
 <m3aa3nqpxz.fsf@intrepid.localdomain>
Message-ID: <4F5D39D1.4050000@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/12 22:31, Krzysztof Halasa wrote:
> Greg Ungerer<gerg@snapgear.com>  writes:
>
>> The built in ethernet interfaces on the ixp4xx family are not PCI
>> based. So they at least do not suffer from the BE/LE conversions
>> at the eth driver.
>
> The problematic one is IXP42x rev. A0. It has no support for hw mixed
> mode (LE core + lane swapping where needed). Unfortunately this early

It is not problematic if you are running your core BE right?

Regards
Greg



> chip is quite popular. "Software" mixed mode means byte swapping in the
> network drivers and IIRC the crypto accelerator becomes unusable (at
> least without workarounds).
>
> Later revisions (42x rev. B0 and up, and all other IXP4[356]) can work
> in the most efficient hw mixed mode. Support is not upstream but it's
> basically ready. I think it may be incompatible with XIP.


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
