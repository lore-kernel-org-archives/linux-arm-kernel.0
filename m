From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 19 Jan 2011 12:25:18 +0900
Subject: [PATCH] drivers: ld9040 amoled driver support
In-Reply-To: <4D364EFF.6080401@samsung.com>
References: <1294893628-16998-1-git-send-email-dh09.lee@samsung.com>
	<4D364EFF.6080401@samsung.com>
Message-ID: <20110119032518.GD19486@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 11:39:59AM +0900, Donghwa Lee wrote:
>  Dear Richard Purdie,
> 
> I had sent ld9040 amoled driver patch file for several times with expectation for your comment.
> But, there was no comment about that. I was somewhat disappointed.
> 
> That patch is working well on my board and it is very smilar framework as s6e63m0 that already
> included mainline. Please reply with any comment.
> I'm looking forward to your reply.

The backlight stuff seems to be effectively abandoned at this point, and
it's not clear if there is anyone else willing to maintain it. For these
sorts of situations patches are generally best fed through -mm, which
provides some time for review from unresponsive maintainers as well as
leading towards a merge path.

I'm not sure what the best way to handle the backlight stuff is however,
in that much of it keeps popping up on the fbdev list and each time we
either need to poke Richard multiple times or shuffle it off to Andrew.
This also understandably leads to frustration for people submitting new
drivers in that the submission path they are directed towards via
MAINTAINERS ends up largely being a black hole.

For now the easiest option is still likely to be just making Andrew aware
of it, while gradually leaning towards -mm as the primary path for
backlight patches.
