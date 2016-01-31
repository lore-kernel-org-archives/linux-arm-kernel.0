From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 31 Jan 2016 18:25:51 +0100
Subject: [PATCH v4 11/13] PM / Hibernate: Call flush_icache_range() on
 pages restored in-place
In-Reply-To: <1453977766-20907-12-git-send-email-james.morse@arm.com>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
 <1453977766-20907-12-git-send-email-james.morse@arm.com>
Message-ID: <20160131172551.GB3721@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2016-01-28 10:42:44, James Morse wrote:
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

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
