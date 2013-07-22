From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 22 Jul 2013 17:49:04 +0100
Subject: updates for be8 patch series
In-Reply-To: <1374510833-25716-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1374510833-25716-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <51ED6280.7020901@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/13 17:33, Ben Dooks wrote:
> I've updated the BE8 patch series after running further tests on the
> kernel. I found an issue with the alignment handler (and I believe the
> same issue with the trap handler).
>
> I also ran tests with the module loader, which shows that if we are
> in BE8 that it needs to fix up the relocations. Also the modules need
> to be built --be8 otherwise they cannot be easily relocated when loaded.
>
> Should patches 3 and 4 be together (ie, alter the LDFLAGS and the
> module.c) and have I got the correct LDLAGS?
>
> Comments and testing welcome. I will push out a new series later with
> these in and possibly rebased on 3.11-rc2.

New series based on 3.10 at:

	git://git.baserock.org/delta/linux.git
		baserock/311/be/core-v3
		baserock/311/be/atags-v3

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
