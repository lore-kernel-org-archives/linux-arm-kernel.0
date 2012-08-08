From: cjb@laptop.org (Chris Ball)
Date: Tue, 07 Aug 2012 23:05:33 -0400
Subject: [PATCH] mmc: atmel-mci: not busy flag has also to be used for
 read operations
In-Reply-To: <1343122924-7799-1-git-send-email-ludovic.desroches@atmel.com>
 (ludovic desroches's message of "Tue, 24 Jul 2012 11:42:04 +0200")
References: <1343122924-7799-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <87lihqxev6.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 24 2012, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Even if the datasheet says that the not busy flag has to be used only for
> write operations, it's false excepted for version lesser than v2xx.
> Not waiting the not busy flag for read operations can cause the controller to
> hang-up during the initialization of some SD cards.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: stable at vger.kernel.org
>
>
> Hello,
>
> This is a fix for 3.5 and later.
>
> Due to the big changes into atmel-mci driver to support all atmel mci versions,
> a bug was introduced.
> With some SD cards (mainly micro) when using DMA, the controller hangs-up after
> the first CMD6 command because the next command is sent too early.
>
> Regards
>
> Ludovic
>
>
> ---
>  drivers/mmc/host/atmel-mci.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Thanks.  I've applied this for mmc-next now, but please put your patch
commentary *underneath* the "---" lines, so that it doesn't end up in
the git history itself.  I've rewritten the commit message to be:


From: Ludovic Desroches <ludovic.desroches@atmel.com>

Even if the datasheet says that the not busy flag has to be used only
for write operations, it's false except for version lesser than v2xx.

Not waiting on the not busy flag for read operations can cause the
controller to hang-up during the initialization of some SD cards
with DMA after the first CMD6 -- the next command is sent too early.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: stable <stable@vger.kernel.org> [3.5, 3.6]
Signed-off-by: Chris Ball <cjb@laptop.org>
---
<patch commentary can go here>

 drivers/mmc/host/atmel-mci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
