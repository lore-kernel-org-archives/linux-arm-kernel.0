From: eric@anholt.net (Eric Anholt)
Date: Tue, 03 Jan 2017 10:27:08 -0800
Subject: [PATCH 1/2] mmc: sdhci-iproc: Apply caps from bcm2835-mmc driver
In-Reply-To: <1483111474-29907-2-git-send-email-stefan.wahren@i2se.com>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
 <1483111474-29907-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87lgusngn7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Since the mmc module on bcm2835 neither provide a capabilities register nor 
> free documentation we must rely on the downstream implementation [1].

Yeah, caps reg is wired to 0, but it can do high speed.

Since we're VDD_330 only, I'm not sure the driver type flags do
anything, but I'm still good with having consistency.

Reviewed-by: Eric Anholt <eric@anholt.net>

Interested in porting over the DMA support? :)

I also noticed that the emmc wrapper module claims it can run with a
clock from 50-100mhz, and the arasan says it can run at up to 50, 52, or
208mhz depending on SD/MMC mode.  Could we get a boost from running the
module at a higher clock rate?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170103/0285a674/attachment.sig>
