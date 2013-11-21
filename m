From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 21 Nov 2013 23:55:09 +0100
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
References: <1384869194.8604.92.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131119174323.GH913@1wt.eu>
 <1384885910.8604.110.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131119184121.GN913@1wt.eu> <874n780wzc.fsf@natisbad.org>
 <20131120191145.GP8581@1wt.eu> <87txf692zx.fsf@natisbad.org>
 <20131120215435.GT8581@1wt.eu> <20131121004430.GX8581@1wt.eu>
 <871u298lv6.fsf@natisbad.org> <20131121215259.GE18513@1wt.eu>
 <1385071201.10637.69.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <87txf54b76.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi eric,

Eric Dumazet <eric.dumazet@gmail.com> writes:

>> > I tested it on my RN2120 (2-core armada XP): I got no problem and the
>> > link saturated w/ apache, nginx and netperf. Good work!
>> 
>> Great, thanks for your tests Arnaud. I forgot to mention that all my
>> tests this evening involved this patch as well.
>
> Now you might try to set a lower value
> for /proc/sys/net/ipv4/tcp_limit_output_bytes

On the RN2120, for a file served from /run/shm (for apache and nginx):

          Apache     nginx       netperf
131072:  102 MB/s   112 MB/s   941.11 Mb/s
 65536:  102 MB/s   112 MB/s   935.97 Mb/s
 32768:  101 MB/s   105 MB/s   940.49 Mb/s
 16384:   94 MB/s    90 MB/s   770.07 Mb/s
  8192:   83 MB/s    66 MB/s   556.79 Mb/s

On the RN102, this time for apache and nginx, the file is served from
disks (ext4/lvm/raid1):

          Apache     nginx       netperf
131072:  66 MB/s   105 MB/s   925.63 Mb/s
 65536:  59 MB/s   105 MB/s   862.55 Mb/s
 32768:  62 MB/s   105 MB/s   918.99 Mb/s
 16384:  65 MB/s   105 MB/s   927.71 Mb/s
  8192:  60 MB/s   104 MB/s   915.63 Mb/s

Values above are for a single flow though.

Cheers,

a+
