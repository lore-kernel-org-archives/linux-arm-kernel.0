From: nyushchenko@dev.rtsoft.ru (Nikita Yushchenko)
Date: Mon, 23 Nov 2015 15:46:00 +0300
Subject: [RFC/PATCH] arm: do not skip SMP init calls on SMP_ON_UP case
In-Reply-To: <20151123121920.GP8644@n2100.arm.linux.org.uk>
References: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <20151123120317.GN8644@n2100.arm.linux.org.uk>
 <5653015C.4020405@dev.rtsoft.ru>
 <20151123121216.GO8644@n2100.arm.linux.org.uk>
 <20151123121920.GP8644@n2100.arm.linux.org.uk>
Message-ID: <56530A88.5010408@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

23.11.2015 15:19, Russell King - ARM Linux ?????:
> On Mon, Nov 23, 2015 at 12:12:16PM +0000, Russell King - ARM Linux wrote:
>> iMX6 is fairly well supported in mainline.  The only reason to use a
>> custom kernel is if you want to use some feature which mainline does
>> not support (or support very well) such as video decode, the full IPU
>> facilities, GPUs or CEC (sorry, I don't have an expansive list.)
>>
>> The GPU problem for the GC320/GC880/GC2000 is fairly close to being
>> solved in a functional (but maybe not yet performant) manner.
> 
> For reference, iMX6S in mainline behaves like this:
> 
> Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=12000)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Initializing cgroup subsys net_cls
> CPU: Testing write buffer coherency: ok
> CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> Setting up static identity map for 0x100082c0 - 0x10008318
> Brought up 1 CPUs
> SMP: Total of 1 processors activated (6.00 BogoMIPS).
> CPU: All CPU(s) started in SVC mode.

Indeed, somehow booted mainline and it does not try to initialize CPU 1.
