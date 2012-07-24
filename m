From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 07:51:38 +0000
Subject: [GIT PULL 00/15] arm-soc: changes for v3.6
In-Reply-To: <CA+55aFyObNFgsaVOsjVOcH+aLjDyOgcqpvckM29T3dvugekVwg@mail.gmail.com>
References: <1343075561-17446-1-git-send-email-arnd@arndb.de>
 <CA+55aFyObNFgsaVOsjVOcH+aLjDyOgcqpvckM29T3dvugekVwg@mail.gmail.com>
Message-ID: <201207240751.39111.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 July 2012, Linus Torvalds wrote:

> In your "for-linus" branch, "&mpu_3xxx_clkdm" remains in the
> clockdomains_common[] array. In my merge, it is gone. But I think I
> did the merge correctly, and you did it wrong. HOWEVER, I don't know
> the code, maybe there is some subtle reason why you did it like you
> did.

Yes, I think you are right now that I look at it again. Paul Walmsley
can have another look at the merge and send an update if we are both
missing something now.

> Your "for-linus" branch also had that
> 
>    arch/arm/arm-soc-for-next-contents.txt
> 
> file that shouldn't have been there, but whatever.

That's the file I use for communication with Olof about stuff we
merge. I briefly considered rebuilding a branch for your reference
without it, but since you always do the merges yourself I figured there
would be no need.
We do leave this file in the for-next branch because it helps some
people sending us patches to see what the existing branches and
interdependencies are.

> Anyway, apart from that "please check" comment, I also have small
> complaint: your pull requests didn't actually point to the tags, they
> pointed to the next/xyz commits. So every time I did a pull, I had to
> change "next/xyz" to "tags/xyz". That's just annoying make-work. I
> think it's because you just said "xyz" to the git request-pull script,
> and then git had to pick one of the things and picked next. Please
> disambiguate by just saying "tags/xyz" explicitly.

I spent too much time fiddling with my scripts again in an attempt to
get closer to the regular git-request-pull version. The older version
got this right, but unfortunately I removed the part where I manually
print the right pull address because that had caused other problems
before.
I did the trivial fix you suggested now.

	Arnd
