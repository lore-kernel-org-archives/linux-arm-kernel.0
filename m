From: bill_carson@126.com (rocky)
Date: Mon, 8 Nov 2010 16:56:37 +0800 (CST)
Subject: One quick quenstion about PXA sched_clock resolution?
Message-ID: <3f0ffa72.f9b4.12c2ab386e4.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I'am working on an ARM linux porting project, which need to implement sched_clock of our own.
have a glance at PXA sched_clock timplementation, puzzled about the following notes.


/*
 * This is PXA's sched_clock implementation. This has a resolution
 * of at least 308 ns and a maximum value of 208 days.
 *
 * The return value is guaranteed to be monotonic in that range as
 * long as there is always less than 582 seconds between successive
 * calls to sched_clock() which should always be the case in practice.
 */




PXA series chips have system clock in 3250000/3249600/3686400 HZ.
I do the math like this:

####Where does 308 ns come from?


ns of one clcok cycle:
307.69     (10^9/3250000);
307.73     (10^9/3249600);
271.26     (10^9/3686400 )
this is the highest resolution mentioned in above notes;


####Where does 582 seconds come from?

660.76(0x80000000/3250000);
660.84(0x80000000/3249600); 
582.54(0x80000000/3686400 );


Question is how does 208 days pop out?
Can anyone give me some hints?
thanks


bill
