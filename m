From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Aug 2013 17:08:35 +0100
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <20130812135903.GC25995@mudshark.cambridge.arm.com>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <51FF8E84.7000108@arm.com>
 <20130807014536.GF15579@mudshark.cambridge.arm.com>
 <20130812135903.GC25995@mudshark.cambridge.arm.com>
Message-ID: <20130812160835.GE25995@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[replying to self]

On Mon, Aug 12, 2013 at 02:59:03PM +0100, Will Deacon wrote:
> So, I just tried to test this patch but I'm getting issues when enabling CCI
> with mainline:
> 
> 
> ARM Versatile Express Boot Monitor
> Version:    V5.1.5
> Build Date: Jul 24 2012
> Daughterboard Site 1: V2P-CA15 Cortex A15
> Daughterboard Site 2: V2P-CA15_A7 Cortex A15
> Running boot script from flash - BOOTSCRIPT
> Loaded kernel - linuxtc2
> Booting kernel @ 0x80008000
> Command line 'ip=dhcp root=/dev/nfs nfsroot=10.1.203.36:/exports/linaro-13.06,tcp rw console=ttyAMA0,38400 mem=2G loglevel=9 user_debug=31 earlyprintk debug'
> ATAGs @ 0x80000100
> 
> 
> Fatal Error: Unhandled Exception - Undefined
> 
> 
> We're exploding *really* early, and I have no idea why. If I remove CCI from
> the equation (either in the kernel or the device-tree), then I can boot as
> per usual.

Turns out my .dtb has gone over some limit and appended dtb corrupts the
kernel image. Removing some random nodes got things working again.

Will
