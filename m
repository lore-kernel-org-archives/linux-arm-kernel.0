From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 6 Mar 2014 22:18:21 +0100
Subject: [PATCH 07/10] ARM: mvebu: implement Armada 375 coherency
 workaround
In-Reply-To: <20140306183656.GE1872@titan.lakedaemon.net>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1394124395-20030-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140306183656.GE1872@titan.lakedaemon.net>
Message-ID: <20140306221821.771a0d12@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Thu, 6 Mar 2014 13:36:56 -0500, Jason Cooper wrote:

> On Thu, Mar 06, 2014 at 05:46:32PM +0100, Thomas Petazzoni wrote:
> > The early revisions of Armada 375 SOCs (Z1 stepping) have a bug in the
> 
> Do we have a way to determine that we are on a Z1 at runtime?  It seems
> like we're consuming an XOR engine unconditionally.  I presume that
> Marvell is going to fix this with the next stepping?

Yes, we believe there will be a way to differentiate the Z1 stepping
for the later steppings, using the mvebu-soc-id. However, since those
later steppings are not available yet, we haven't been able to test
this. Our plan is that as soon as we have newer steppings, we will
improve this code to only apply the XOR workaround on the steppings for
which it is needed. It is not clear at this point which stepping
exactly will fix the problem, so we've written the code with the
information that we have today.

Thanks for the feedback!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
