From: stefan@datenfreihafen.org (Stefan Schmidt)
Date: Mon, 7 Jun 2010 09:07:24 +0200
Subject: [RFC PATCH] stargate2 and imote2 board file merge
In-Reply-To: <1275832502-28552-1-git-send-email-jic23@cam.ac.uk>
References: <1275832502-28552-1-git-send-email-jic23@cam.ac.uk>
Message-ID: <20100607070724.GB2702@excalibur.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On Sun, 2010-06-06 at 14:55, Jonathan Cameron wrote:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  These two boards are extremely similar in many ways and hence
>  the board configs overlap a lot.  This patch merges the two
>  board files.  Do people think this is worth doing?  Traditionally
>  we always built a kernel supporting both devices anyway but the
>  ifdefs allow one to be picked if people really want to.

I find it an interesting idea. We have done this on EZX with 6 devices. One
thing that jumps into my face is that we should provide a way to let people know
that the stargate2.c file does indeed also provide support for imote2. At least
updated comments in KConfig and the header of the c file would be needed. That
would allow people to discover it during configuration or greping.

I don't know much about the Crossbow product palette but maybe we should even
rename it to crossbow.c

>  arch/arm/mach-pxa/Makefile    |    2 +-
>  arch/arm/mach-pxa/imote2.c    |  590 -----------------------------------
>  arch/arm/mach-pxa/stargate2.c |  679 +++++++++++++++++++++++++++--------------
>  3 files changed, 454 insertions(+), 817 deletions(-)

Given that we can eliminate nearly 400 lines of code and one board file I think
it is worth it. I looked over the patch and it does look good so far. Will give
it a runtime test the next days. If that truns out well I'm fine to ack it.

regards
Stefan Schmidt
