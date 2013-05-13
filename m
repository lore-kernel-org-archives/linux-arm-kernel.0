From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 13:30:17 -0400
Subject: [PATCH 0/3] ARM: Kirkwood: Add DT support for (eSATA) Sheevaplug
In-Reply-To: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130513173017.GV31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 09:54:57PM +0200, Simon Baatz wrote:
> These patches add DT support for the Sheevaplugs by Globalscale
> Technologies.  There exists two versions, one with an eSATA port and
> one without.
> 
> Surprisingly, the conversion was not straight forward. In the eSATA
> version (board revision 1.3), the CD and WP pins are connected to GPIO
> lines, but I could not get this to work.  Apparently, I am not the only
> one ([1]).  I found that the pins are reversed on my hardware and use
> different active low/active high settings.
> 
> Thus, the first patch adds support for the GPIO active low/high flag in
> DT to the mvsdio driver.
> 
> With that, everything except the Gigabit Ethernet can be described in
> the DTS.  I have split the DTS and the board support files into two
> patches.  This way, we can drop the last patch once we can describe
> everything in the DTS or we can squash them together if we don't want
> to wait.
> 
> I could only test on an eSATA Sheevaplug. I found patches with
> different LEDs for the Sheevaplug.  Thus, I would highly appreciate if
> someone with the hardware could give this a spin on a non-eSATA
> version.  Some additional testing of the change detect and write
> protect behaviour for sdio can't hurt either.  I hope that there aren't
> board revisions with different CD/WP pins out there.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/062567.html
> 
> Simon Baatz (3):
>   mmc: mvsdio: Support inverted CD and WP GPIO lines
>   ARM: Kirkwood: Add dts files for Sheevaplug and eSATA Sheevaplug
>   ARM: Kirkwood: Add DT support for Sheevaplug and Sheevaplug eSATA

Simon,

Were you able to find any time to work on this?

thx,

Jason.
