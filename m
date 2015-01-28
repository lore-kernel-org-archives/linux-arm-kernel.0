From: corbet@lwn.net (Jonathan Corbet)
Date: Wed, 28 Jan 2015 14:57:41 -0700
Subject: [PATCH 6/7] [media] marvell-ccic: MMP_CAMERA never worked
In-Reply-To: <1422479867-3370921-7-git-send-email-arnd@arndb.de>
References: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
 <1422479867-3370921-7-git-send-email-arnd@arndb.de>
Message-ID: <20150128145741.02812a8f@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jan 2015 22:17:46 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> The mmp ccic driver uses a platform_data structure that has never
> existed in an upstream kernel and always fails to build:

This driver most assuredly did work on XO 1.75 machines, and the
platform_data structure does exist; it's the stuff added by Libin
afterward that apparently broke things.  Strange that it only came out now,
though, nearly two years later. Libin, any thoughts on this?

Meanwhile, it is clearly broken, and I don't have an immediate fix, so,

Acked-by: Jonathan Corbet <corbet@lwn.net>

(Though I would like a different patch subject, since the current one is
wrong).

I think the right thing to do, alas, might be to back out all of Libin's
changes.  They clearly are not being used by anybody and do not seem to be
getting any further development attention.  It would like to keep this
driver working for XO systems for a while yet...but I won't get to it
right away.

Thanks,

jon
