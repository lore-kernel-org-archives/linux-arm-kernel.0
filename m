From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 4 Jan 2011 09:41:02 +0900
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <20110103151944.GA32508@n2100.arm.linux.org.uk>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
	<20110103151944.GA32508@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik2_qFoT-CUhhWL6o5PN9m8RyE-R+0t1HUo9+oq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 4, 2011 at 12:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> I've not decided whether it should be possible to resume an ETIMEOUT'd
> pause request (in theory with pl08x, that's just a matter of clearing
> the HALT bit) or whether an ETIMEOUT'd pause request should restore
> the previous HALT bit setting (possibly re-enabling transfers on the
> channel.) ?Allowing it to be re-enabled in some way would be the safest
> thing in terms of data integrity for the reason mentioned in the
> "important note" above.

Not sure if every DMAC could resume cleanly from exact pause point.
Perhaps the upper layer of client driver should take care of that, just
like ALSA which emulates pause/resume if the 'optional' capability is
not advertised by the audio dma driver.
