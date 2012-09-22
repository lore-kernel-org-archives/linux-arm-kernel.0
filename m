From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Sat, 22 Sep 2012 17:45:12 +0200
Subject: rcu self-detected stall messages on OMAP3, 4 boards
In-Reply-To: <20120921220302.GF2454@linux.vnet.ibm.com>
References: <alpine.DEB.2.00.1209200753450.3801@utopia.booyaka.com>
 <F95344A7-3351-4E6B-BF61-37E591AF16A2@ti.com>
 <20120920220130.GN2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209202244470.32589@utopia.booyaka.com>
 <20120920232114.GO2449@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211803290.8839@utopia.booyaka.com>
 <20120921185827.GC2454@linux.vnet.ibm.com>
 <alpine.DEB.2.00.1209211900520.8839@utopia.booyaka.com>
 <20120921195717.GD2454@linux.vnet.ibm.com>
 <20120921203149.GI28835@atomide.com>
 <20120921220302.GF2454@linux.vnet.ibm.com>
Message-ID: <CAFTL4hy5wO9CL5_1e8U7L3Tihm_HYD6uAsda3ue-zDKFjir2Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/9/22 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> On Fri, Sep 21, 2012 at 01:31:49PM -0700, Tony Lindgren wrote:
>> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [120921 12:58]:
>> >
>> > Just to make sure I understand the combinations:
>> >
>> > o   All stalls have happened when running a minimal userspace.
>> > o   CONFIG_NO_HZ=n suppresses the stalls.
>> > o   CONFIG_RCU_FAST_NO_HZ (which depends on CONFIG_NO_HZ=y) has
>> >     no observable effect on the stalls.
>>
>> The reason why you may need minimal userspace is to cut down
>> the number of timers waking up the system with NO_HZ.
>> Booting with init=/bin/sh might also do the trick for that.
>
> Good point!  This does make for a very quiet system, but does not
> reproduce the problem under kvm, even after waiting for four minutes.
> I will leave it for more time, but it looks like I really might need to
> ask Linaro for remote access to a Panda.

I have one. I'm currently installing Ubuntu on it and I'll try to
manage to build
a kernel and reproduce the issue.

I'll give more news soon.
