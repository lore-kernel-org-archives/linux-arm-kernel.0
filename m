From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Apr 2016 18:16:43 +0100
Subject: [PATCH v7 14/16] PM / Hibernate: Call flush_icache_range() on
 pages restored in-place
In-Reply-To: <1459529620-22150-15-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-15-git-send-email-james.morse@arm.com>
Message-ID: <20160420171643.GH11377@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 05:53:38PM +0100, James Morse wrote:
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches before the processor can fetch them as new
> instructions.
> 
> During resume from hibernate, the snapshot code copies some pages directly,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Modify the read and decompress code to call
> flush_icache_range() on all pages that are restored, so that the restored
> in-place pages are guaranteed to be executable on these architectures.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
