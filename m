From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 Apr 2013 07:00:34 +0200
Subject: [PATCH 0/3] ARM: Kirkwood: Add DT support for (eSATA) Sheevaplug
In-Reply-To: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130423050034.GA8710@lunn.ch>
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

Hi Simon

Patches 2 and 3 look good to me. If you submit a new version with the
SDIO issue resolved i can give you a Acked-by:

     Thanks
	Andrew
