From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 07:19:03 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <500DC255.40900@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201207171924.33756.arnd@arndb.de> <500DC255.40900@wwwdotorg.org>
Message-ID: <201207240719.03601.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 July 2012, Stephen Warren wrote:
> > 3. A device with three channels, one of which has two alternatives:
> 
> s/three/four/   s/one of which/both of which/
> 
> This binding doc seems reasonable to me.

I asked a linguist about it who said that you can't have "both" together
with "four". She also mentioned that my text is rather confusing, so maybe
you also got it wrong. I'll try adding some explanation:

3. A device with three channels, one of which has two alternatives:

        dmas = <&dma0 1 4   /* first channel,  data read */
                &dma0 2 6   /* second channel, data write */
                &dma1 1 0   /* third channel,  error read */
                &dma2 1 0>; /* third channel,  ernative error read */
        dma-names = "data", "data", "error", "error";

   The first two channels are identified by having a unique direction
   flag in combination with the "data" string. For the third channel,
   there are two dma specifiers with identical flags (1) and strings
   ("error"), so only one specifier may be used at a time.

	Arnd
