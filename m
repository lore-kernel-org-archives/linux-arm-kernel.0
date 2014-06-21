From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 21 Jun 2014 08:11:12 +0200
Subject: [PATCH RFC 30/30] net: fec: consolidate hwtstamp implementation
In-Reply-To: <E1Wxxhw-0005Yn-Ey@rmk-PC.arm.linux.org.uk>
References: <20140620121118.GR32514@n2100.arm.linux.org.uk>
 <E1Wxxhw-0005Yn-Ey@rmk-PC.arm.linux.org.uk>
Message-ID: <20140621061112.GA3965@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 01:14:16PM +0100, Russell King wrote:
> Both transmit and receive use the same infrastructure for calculating
> the packet timestamp.  Rather than duplicating the code, provide a
> function to do this common work.  Model this function in the Intel
> e1000e version which avoids calling ns_to_ktime() within the spinlock;
> the spinlock is critical for timecounter_cyc2time() but not
> ns_to_ktime().

Thanks for cleaning this up.

Acked-by: Richard Cochran <richardcochran@gmail.com>
