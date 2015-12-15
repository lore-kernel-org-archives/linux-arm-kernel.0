From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Dec 2015 09:34:07 +0000
Subject: memcpy alignment
In-Reply-To: <566F92D6.8060103@redhat.com>
References: <566F92D6.8060103@redhat.com>
Message-ID: <20151215093406.GC19244@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 11:11:02PM -0500, Jon Masters wrote:
> What's supposed to happen if the natural alignment of the pointers dst
> and src is not the same? We don't seem to handle that case today, and
> instead will base our access data type on the source alignment only.

The hardware takes care of the other one. The memcpy behaviour in the
kernel is the same as the glibc one (the Cortex Strings library).

-- 
Catalin
