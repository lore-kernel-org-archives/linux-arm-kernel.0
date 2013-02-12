From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 17:18:48 +0000
Subject: [PATCH 6/9] gpiolib: use descriptors internally
In-Reply-To: <20130212155927.GE6088@linux-sh.org>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <CACRpkdaHuv7CXCy15-o94G0r0+2BStsi34ZVbBAhyGj=U3xgOg@mail.gmail.com>
 <20130212155927.GE6088@linux-sh.org>
Message-ID: <201302121718.48244.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Paul Mundt wrote:
> > While I do get the point... I chatted with Grant about it and
> > I want to talk to some toolchain people about this to see if
> > pointers containing potential error codes can somehow be
> > "flagged" by the compiler so we can enforce error checking on
> > them. (It may sound a bit utopic...)
> > 
> At the very least you can __must_check annotate, although that's probably
> still a bit coarser grained than what you're after.

There is an idea: we could have variants of __must_check for different
classes of returns: NULL error, ERR_PTR, negative integer on error, ...

	Arnd
