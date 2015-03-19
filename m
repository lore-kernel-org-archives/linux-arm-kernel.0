From: joshc@ni.com (Josh Cartwright)
Date: Thu, 19 Mar 2015 08:49:11 -0500
Subject: [PATCH 2/2] ARM: zynq: drop use of slcr_unlock in
 zynq_slcr_system_restart
In-Reply-To: <1426772033-29277-2-git-send-email-joshc@ni.com>
References: <BN1BFFO11FD008F29B247339CE49EAEA6AE2010@BN1BFFO11FD008.protection.gbl>
 <1426772033-29277-1-git-send-email-joshc@ni.com>
 <1426772033-29277-2-git-send-email-joshc@ni.com>
Message-ID: <20150319134911.GC23626@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ugh.

On Thu, Mar 19, 2015 at 08:33:53AM -0500, Josh Cartwright wrote:
> The SLCR is unconditionally unlocked early on boot in zynq_slcr_init()
> and not unlocked.  As such, it is not necessary to explicitly unlock in

          ^ever re-locked.

Can you fix this up when you apply?

Thanks,
  Josh
