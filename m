From: eric@anholt.net (Eric Anholt)
Date: Wed, 16 Dec 2015 16:37:37 -0800
Subject: [PATCH v2 0/8] Raspberry Pi 2 support.
In-Reply-To: <21040591.KakM5Gl6ZZ@wuerfel>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <21040591.KakM5Gl6ZZ@wuerfel>
Message-ID: <874mfhsyem.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 16 December 2015 15:55:07 Eric Anholt wrote:
>> This is a major rewrite of the previous Raspberry Pi 2 submission.
>> SMP support is now included, and the DT includes are cleaned up to
>> avoid massive duplication.
>> 
>> The branch (based on 4.4-rc5, to get the USB regression fixes) can be
>> found at:
>> 
>> https://github.com/anholt/linux/tree/bcm2836-4.4
>
> Looks all good to me, but when we get the pull request, I'd strongly
> prefer to have that based on -rc3 or earlier.
>
> What commit is the USB regression fix you refer to above? Is that in a
> branch that is -rc3 based? Maybe you can rebase the changes on top
> of that branch, to minimize the amount of backmerges?

Top 4 commits of drivers/usb/dwc2 for 4.4-rc5 (possibly not all of them
are required, but it's what I've been using).  I've been using
cherry-picks of them on top of my various branches for testing, but pi2
was going to be rebased so many times in the process of cleanup that I
put it underneath my development branch instead.

I've been doing pull requests for my stuff on -rc1 tags.  It sucks for
bisecting any breakage I produce when I can't boot that directly, but I
don't see a good way to avoid this kind of pain other than getting some
Pis into kernel-ci.org so we can catch regressions earlier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151216/2bb7e82a/attachment.sig>
