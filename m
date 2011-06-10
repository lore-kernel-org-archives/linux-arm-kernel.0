From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Fri, 10 Jun 2011 16:59:54 +0100
Subject: [PATCH 00/10] mm: Linux VM Infrastructure to support Memory
	Power Management
In-Reply-To: <20110610151121.GA2230@linux.vnet.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110528005640.9076c0b1.akpm@linux-foundation.org>
	<20110609185259.GA29287@linux.vnet.ibm.com>
	<BANLkTinxeeSby_+tta8EhzCg3VbD6+=g+g@mail.gmail.com>
	<20110610151121.GA2230@linux.vnet.ibm.com>
Message-ID: <20110610155954.GA25774@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 08:11:21AM -0700, Paul E. McKenney wrote:

> Of course, on a server, you could get similar results by having a very
> large amount of memory (say 256GB) and a workload that needed all the
> memory only occasionally for short periods, but could get by with much
> less (say 8GB) the rest of the time.  I have no idea whether or not
> anyone actually has such a system.

For the server case, the low hanging fruit would seem to be 
finer-grained self-refresh. At best we seem to be able to do that on a 
per-CPU socket basis right now. The difference between active and 
self-refresh would seem to be much larger than the difference between 
self-refresh and powered down.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
