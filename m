From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Jul 2012 01:12:47 -0700
Subject: [GIT PULL 00/15] arm-soc: changes for v3.6
In-Reply-To: <201207240751.39111.arnd@arndb.de>
References: <1343075561-17446-1-git-send-email-arnd@arndb.de>
 <CA+55aFyObNFgsaVOsjVOcH+aLjDyOgcqpvckM29T3dvugekVwg@mail.gmail.com>
 <201207240751.39111.arnd@arndb.de>
Message-ID: <20120724081246.GS6522@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120724 00:57]:
> On Tuesday 24 July 2012, Linus Torvalds wrote:
> 
> > In your "for-linus" branch, "&mpu_3xxx_clkdm" remains in the
> > clockdomains_common[] array. In my merge, it is gone. But I think I
> > did the merge correctly, and you did it wrong. HOWEVER, I don't know
> > the code, maybe there is some subtle reason why you did it like you
> > did.
> 
> Yes, I think you are right now that I look at it again. Paul Walmsley
> can have another look at the merge and send an update if we are both
> missing something now.

Yes thanks looks good. We've had the mismerge there from my earlier
merge as noted by Paul. Looks like clockdomain.[ch] parts need some
patching.

> > Anyway, apart from that "please check" comment, I also have small
> > complaint: your pull requests didn't actually point to the tags, they
> > pointed to the next/xyz commits. So every time I did a pull, I had to
> > change "next/xyz" to "tags/xyz". That's just annoying make-work. I
> > think it's because you just said "xyz" to the git request-pull script,
> > and then git had to pick one of the things and picked next. Please
> > disambiguate by just saying "tags/xyz" explicitly.
> 
> I spent too much time fiddling with my scripts again in an attempt to
> get closer to the regular git-request-pull version. The older version
> got this right, but unfortunately I removed the part where I manually
> print the right pull address because that had caused other problems
> before.

FYI, this issue happens also with git request-pull if the tag has not
yet gotten mirrored but the branch is already mirrored.

Regards,

Tony
