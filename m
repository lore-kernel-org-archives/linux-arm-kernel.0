From: brad@heeltoe.com (Brad Parker)
Date: Fri, 27 Nov 2015 10:55:35 -0500
Subject: armv7 + lpae broken in 4.1.12+ ?
In-Reply-To: <20151127093601.GA25781@arm.com>
References: <5657952E.906@heeltoe.com> <20151127093601.GA25781@arm.com>
Message-ID: <56587CF7.9060302@heeltoe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/15 4:36 AM, Will Deacon wrote:> As Russell says, AEABI requires 
the 64-bit pte value to be passed in > r2 and r3 for cpu_v7_set_pte_ext: 
 > > C.3 If the argument requires double-word alignment (8-byte), the > 
NCRN is rounded up to the next even register number. > >> The simple fix 
is to add "mov r3, r2; mov r2,r1" at the begining >> of 
cpu_v7_set_pte_ext(), but that's a hack (but it does solve the >> 
problem and the kernel boots). > > ... so this would actually cause 
breakage for other people. > > Which toolchain are you using?
[sorry for the re-send;  I keep getting bounced by the email.html 
filter; not sure why]

That all makes sense. I'm using a linaro toolchain (which I'll admit I
grabbed because I was lazy)

gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux/bin/arm-linux-gnueabihf-

It seems really odd.  I would have thought "gnueabihf" would be EABI, so
a 64 bit arg should be in r2,r3; but it's not.  It's in r1, r2.

could something in my .config cause this?  (I'd be surprised if that were the case, but...).

I'm happy to try a better toolchain if you can point me to one (binary).

-brad
