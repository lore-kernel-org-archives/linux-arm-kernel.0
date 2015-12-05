From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 5 Dec 2015 10:35:34 +0100
Subject: [PATCH v3 09/10] PM / Hibernate: Publish pages restored in-place
 to arch code
In-Reply-To: <1448559168-8363-10-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-10-git-send-email-james.morse@arm.com>
Message-ID: <20151205093534.GA7569@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2015-11-26 17:32:47, James Morse wrote:
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches before the processor can fetch them as new
> instructions.
> 
> During resume from hibernate, the snapshot code copies some pages directly,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Create a new list of pages that were restored in place, so
> that the arch code can perform this maintenance when necessary.

Umm. Could the copy function be modified to do the neccessary
flushing, instead?

Alternatively, can you just clean the whole cache before jumping to
the new kernel?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
