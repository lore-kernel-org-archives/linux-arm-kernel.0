From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 06 Apr 2011 15:39:11 +0100
Subject: For SMP, Is platform specific secondary startup function
	really needed?
In-Reply-To: <7b2e9aed-1162-43f3-8c33-59b43b0a1964@VA3EHSMHS036.ehs.local>
References: <7b2e9aed-1162-43f3-8c33-59b43b0a1964@VA3EHSMHS036.ehs.local>
Message-ID: <1302100751.28846.6.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-04-06 at 14:48 +0100, John Linn wrote:
> I'm doing some cleanup of SMP patches based on Russell and Catalin's
> input which was real helpful. It seems to me that there is not always a
> need for a platform specific secondary startup.
> 
> I have tested with just letting CPU1 go straight to secondary_startup()
> in head.S and it works fine.
> 
> I'm probably missing something obvious, if so can you share it?

We use the pen release mechanism serialise the secondary CPUs booting.

-- 
Catalin
