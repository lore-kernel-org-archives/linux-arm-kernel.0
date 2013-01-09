From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 10:35:22 +0000
Subject: [PATCH 1/4] gpiolib: introduce descriptor-based GPIO interface
In-Reply-To: <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301081259.29839.arnd@arndb.de>
 <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
Message-ID: <201301091035.23206.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Alexandre Courbot wrote:
> On Tue, Jan 8, 2013 at 9:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Please avoid the use of IS_ERR_OR_NULL(), especially on interfaces you
> > introduce yourself. AFAICT, gpiod_get cannot return NULL, so you
> > should not check for that.
> 
> Sure - you sound like IS_ERR_OR_NULL() is generally considered evil,

Correct.

> may I ask why this is the case?

It's very hard to get right: either you are interested in the error code,
and then you don't have one in some cases, or you don't care but have
to check for it anyway. When you define a function, just make it clear
what the expected return values are, either NULL for error or a negative
ERR_PTR value, but not both.

	Arnd
