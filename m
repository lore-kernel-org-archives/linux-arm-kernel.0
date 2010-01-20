From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Jan 2010 10:01:55 +0000
Subject: git pre-commit hook running checkpatch.pl
In-Reply-To: <20100120020202.GE26562@trinity.fluff.org>
References: <20100120020202.GE26562@trinity.fluff.org>
Message-ID: <20100120100155.GA851@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 02:02:02AM +0000, Ben Dooks wrote:

> I've written a git pre-commit[1] hook which stops any commits happening if
> checkpatch.pl reports problems with the patch. Any comments?

> [1] http://www.fluff.org/ben/linux/githooks/pre-commit

Checkpatch does sometimes generate the occasional false positive which
can be annoying when they trigger.  It can also be a problem when doing
bugfixes IME - if an existing file has lots of checkpatch issues then a
fix which maintains the same coding style as the surrounding code can
trigger checkpatch issues which would if fixed make the code not fit in
with the rest of the file.  Obviously it'd be desirable to fix the file
but that's a bit unreasonable for people submitting bug fixes,
especially when pushing fixes to Linus and stable.

That said, monitoring for checkpatch issues is useful.
