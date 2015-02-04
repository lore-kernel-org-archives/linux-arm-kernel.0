From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Feb 2015 15:16:24 +0000
Subject: [rcu] [ INFO: suspicious RCU usage. ]
In-Reply-To: <20150204151028.GD5370@linux.vnet.ibm.com>
References: <20150201025922.GA16820@wfg-t540p.sh.intel.com>
 <1422957702.17540.1.camel@AMDC1943>
 <20150203162704.GR19109@linux.vnet.ibm.com>
 <1423049947.19547.6.camel@AMDC1943>
 <20150204130018.GG8656@n2100.arm.linux.org.uk>
 <20150204131420.GC5370@linux.vnet.ibm.com>
 <1423059387.24415.2.camel@AMDC1943>
 <20150204151028.GD5370@linux.vnet.ibm.com>
Message-ID: <20150204151624.GI8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 07:10:28AM -0800, Paul E. McKenney wrote:
> You know, this situation is giving me a bad case of nostalgia for the
> old Sequent Symmetry and NUMA-Q hardware.  On those platforms, the
> outgoing CPU could turn itself off, and thus didn't need to tell some
> other CPU when it was ready to be turned off.  Seems to me that this
> self-turn-off capability would be a great feature for future systems!

Unfortunately, some briliant people decided that secure firmware on
their platforms (which is sometimes needed to turn the secondary CPUs
off) can only be called by CPU0...

Other people decide that they can power down the secondary CPU when it
hits a WFI (wait for interrupt) instruction after arming that state
change, which is far saner - but we still need to know on the requesting
CPU when the dying CPU has completed the time-expensive parts of the
offlining process.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
