From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Apr 2015 14:38:10 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <6C99D1ED-37A9-4E68-A137-BF8F78720BFE@caviumnetworks.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <332955D5-3122-437B-93A1-E1973BE09FCA@theobroma-systems.com>
 <AC03A80E-49F8-4A08-9DDA-0B9F8B734F51@theobroma-systems.com>
 <17844053.vZiPCu4un3@wuerfel>
 <6C99D1ED-37A9-4E68-A137-BF8F78720BFE@caviumnetworks.com>
Message-ID: <20150414133810.GC14546@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 10:45:43AM +0000, Pinski, Andrew wrote:
> Also about time_t, my original patch had used 32bit but was asked to
> change it to the 64bit one. So now I am upset this being asked again
> to change it back.

At the time, we were not aware of plans to fix existing 32-bit
architectures, so we followed Linus' similar request on x32.

> The review process for the linux kernel is much harder than the review
> process of gcc or even glibc now. 

This is not really about kernel code review but about defining the
user/kernel ABI. It shouldn't even be a kernel-only decision, we need to
get the libc people involved. So yes, you get to prototype such ABI in
several kernel patch incarnations and code may be thrown away but that's
better than making the wrong decision on the long run.

As for gcc, the ILP32 ABI is clear to them, they only have to review
implementation details.

-- 
Catalin
