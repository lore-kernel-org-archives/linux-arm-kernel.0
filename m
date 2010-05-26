From: chasedouglas@gmail.com (Chase Douglas)
Date: Wed, 26 May 2010 08:59:40 -0400
Subject: [RFC PATCH v2 0/3] ep93xx i2s audio
In-Reply-To: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
References: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1274878780.9346.41.camel@cndougla-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-26 at 17:09 +1200, Ryan Mallon wrote:
> The following patch series adds support for i2s audio on the ep93xx,
> with the Snapper CL15 used as an example implementation. 
> 
> I have created psuedo clocks for sclk and lrclk as suggested by
> Hartley/Mark. This moves the sdiv/lrdiv calculation into
> ep93xx_i2s_hw_parms. The ep93xx documentation implies that lrclk is
> gated for unused bits (ie if lrdiv > word length). If this is true for
> all ep93xx i2s setups then the lrclk/sclk's could be replaced by a
> single audio rate clock.
> 
> I have fixed the enabling/disabling of the i2s peripheral, which
> corrects the problem I was having with playback sometimes resulting in
> noise.

Cool!

As I looked through the patches briefly, I noticed that the first patch
depends on the second. I think they should be swapped in order so that
it is compilable after each commit. This is important when using tools
like git bisect.

-- Chase
