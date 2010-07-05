From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 05 Jul 2010 15:04:33 +0200
Subject: Some benchmarks on ARM
In-Reply-To: <alpine.LFD.2.00.1007030136510.32016@xanadu.home>
References: <20100702180257.GA8767@pengutronix.de>
	<alpine.LFD.2.00.1007030136510.32016@xanadu.home>
Message-ID: <4C31D861.607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 03-07-10 07:44, Nicolas Pitre schreef:
> On Fri, 2 Jul 2010, Robert Schwebel wrote:
> 
>> Hi,
>>
>> We have recently made some benchmarks, in order to get a little bit
>> better fealing about where ARM cpus are today, especially when it comes
>> to the "recent" ones, and in comparism to the Atom. So we collected a
>> few benchmarks (most from lmbench) and did some actual measurements.
>>
>> Here is a little article:
>> http://www.pengutronix.de/development/kernel/arm-benchmarks-20100702_en.html
>>
>> I'm pretty sure that there are quite a few things where people on ALKML
>> have good ideas where the effects come from or how to improve the
>> methodology - so I'd be glad to get some feedback from the community!
> 
> It would be nice if you could add measurements for recent Marvell 
> products there, such as the Kirkwood (think SheevaPlug or the like 
> running at 1.2 GHz), or Dove.  I wold expect memory throughput on those 
> to be quite good.

Some quick tests of lmbench on a Sheevaplug:

mcuelenaere at kot:/dev/shm/lmbench3/bin/armv5tel-linux-gnu$ ./lat_ops 
integer bit: 0.85 nanoseconds
integer add: 0.02 nanoseconds
integer mul: 0.42 nanoseconds
integer div: 147.77 nanoseconds
integer mod: 36.94 nanoseconds
int64 bit: 1.71 nanoseconds
int64 add: 0.04 nanoseconds
int64 mul: 0.92 nanoseconds
int64 div: 425.89 nanoseconds
int64 mod: 273.85 nanoseconds
float add: 36.25 nanoseconds
float mul: 30.32 nanoseconds
float div: 161.29 nanoseconds
double add: 51.21 nanoseconds
double mul: 46.31 nanoseconds
double div: 542.06 nanoseconds
float bogomflops: 325.59 nanoseconds
double bogomflops: 799.14 nanoseconds

mcuelenaere at kot:/dev/shm/lmbench3/bin/armv5tel-linux-gnu$ mbw 128
Long uses 4 bytes. Allocating 2*33554432 elements = 268435456 bytes of memory.
Using 262144 bytes as blocks for memcpy block copy test.
Getting down to business... Doing 10 runs per test.
0	Method: MEMCPY	Elapsed: 0.48203	MiB: 128.00000	Copy: 265.546 MiB/s
1	Method: MEMCPY	Elapsed: 0.48165	MiB: 128.00000	Copy: 265.751 MiB/s
2	Method: MEMCPY	Elapsed: 0.48163	MiB: 128.00000	Copy: 265.764 MiB/s
3	Method: MEMCPY	Elapsed: 0.49714	MiB: 128.00000	Copy: 257.473 MiB/s
4	Method: MEMCPY	Elapsed: 0.48168	MiB: 128.00000	Copy: 265.737 MiB/s
5	Method: MEMCPY	Elapsed: 0.48163	MiB: 128.00000	Copy: 265.764 MiB/s
6	Method: MEMCPY	Elapsed: 0.49695	MiB: 128.00000	Copy: 257.570 MiB/s
7	Method: MEMCPY	Elapsed: 0.48196	MiB: 128.00000	Copy: 265.579 MiB/s
8	Method: MEMCPY	Elapsed: 0.48164	MiB: 128.00000	Copy: 265.761 MiB/s
9	Method: MEMCPY	Elapsed: 0.49695	MiB: 128.00000	Copy: 257.570 MiB/s
AVG	Method: MEMCPY	Elapsed: 0.48633	MiB: 128.00000	Copy: 263.198 MiB/s
0	Method: DUMB	Elapsed: 0.29804	MiB: 128.00000	Copy: 429.475 MiB/s
1	Method: DUMB	Elapsed: 0.29807	MiB: 128.00000	Copy: 429.429 MiB/s
2	Method: DUMB	Elapsed: 0.29815	MiB: 128.00000	Copy: 429.310 MiB/s
3	Method: DUMB	Elapsed: 0.29800	MiB: 128.00000	Copy: 429.530 MiB/s
4	Method: DUMB	Elapsed: 0.31337	MiB: 128.00000	Copy: 408.458 MiB/s
5	Method: DUMB	Elapsed: 0.29805	MiB: 128.00000	Copy: 429.462 MiB/s
6	Method: DUMB	Elapsed: 0.29808	MiB: 128.00000	Copy: 429.411 MiB/s
7	Method: DUMB	Elapsed: 0.29801	MiB: 128.00000	Copy: 429.510 MiB/s
8	Method: DUMB	Elapsed: 0.29809	MiB: 128.00000	Copy: 429.403 MiB/s
9	Method: DUMB	Elapsed: 0.31339	MiB: 128.00000	Copy: 408.437 MiB/s
AVG	Method: DUMB	Elapsed: 0.30113	MiB: 128.00000	Copy: 425.072 MiB/s
0	Method: MCBLOCK	Elapsed: 0.21906	MiB: 128.00000	Copy: 584.317 MiB/s
1	Method: MCBLOCK	Elapsed: 0.21554	MiB: 128.00000	Copy: 593.852 MiB/s
2	Method: MCBLOCK	Elapsed: 0.21577	MiB: 128.00000	Copy: 593.238 MiB/s
3	Method: MCBLOCK	Elapsed: 0.21671	MiB: 128.00000	Copy: 590.646 MiB/s
4	Method: MCBLOCK	Elapsed: 0.21479	MiB: 128.00000	Copy: 595.942 MiB/s
5	Method: MCBLOCK	Elapsed: 0.23519	MiB: 128.00000	Copy: 544.232 MiB/s
6	Method: MCBLOCK	Elapsed: 0.21705	MiB: 128.00000	Copy: 589.734 MiB/s
7	Method: MCBLOCK	Elapsed: 0.59684	MiB: 128.00000	Copy: 214.464 MiB/s
8	Method: MCBLOCK	Elapsed: 0.21699	MiB: 128.00000	Copy: 589.889 MiB/s
9	Method: MCBLOCK	Elapsed: 0.21418	MiB: 128.00000	Copy: 597.642 MiB/s
AVG	Method: MCBLOCK	Elapsed: 0.25621	MiB: 128.00000	Copy: 499.589 MiB/s

Couldn't get lat_ctx to work.

mcuelenaere at kot:/dev/shm/lmbench3/bin/armv5tel-linux-gnu$ ./lat_syscall open
Simple open/close: 7.2754 microseconds
mcuelenaere at kot:/dev/shm/lmbench3/bin/armv5tel-linux-gnu$ ./lat_syscall open /dev/shm/lmbench3.tar 
Simple open/close: 6.9399 microseconds

mcuelenaere at kot:/dev/shm/lmbench3/bin/armv5tel-linux-gnu$ ./lat_proc fork
Process fork+exit: 763.5714 microseconds

mcuelenaere at kot:/dev/shm/lmbench3/bin/armv5tel-linux-gnu$ cat /proc/cpuinfo 
Processor	: Feroceon 88FR131 rev 1 (v5l)
BogoMIPS	: 1192.75
Features	: swp half thumb fastmult edsp 
CPU implementer	: 0x56
CPU architecture: 5TE
CPU variant	: 0x2
CPU part	: 0x131
CPU revision	: 1

Hardware	: Marvell SheevaPlug Reference Board
Revision	: 0000
Serial		: 0000000000000000


I'm not sure if I'm doing this right, but it looks like the Sheevaplug beats all ARM chips (except
on FP) on the tests done at [1]. Looks like these tests heavily depend on the clock frequency.

[1]: http://www.pengutronix.de/development/kernel/arm-benchmarks-20100702_en.html

-- 
Maurus Cuelenaere
