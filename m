From: duwe@suse.de (Torsten Duwe)
Date: Tue, 20 Jun 2017 16:59:33 +0200
Subject: [PATCH v2 0/3] add support of hardware random generator on
 MediaTek MT7622
In-Reply-To: <1497968477.27946.5.camel@mtkswgap22>
References: <cover.1497280813.git.sean.wang@mediatek.com>
 <20170620034009.GD17764@gondor.apana.org.au>
 <1497968477.27946.5.camel@mtkswgap22>
Message-ID: <20170620145933.GA4177@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 10:21:17PM +0800, Sean Wang wrote:
> Hi Herbert,
> 
> thanks for effort reviewing on those patches.
> 
> By the way, also loop in Torsten
> 
> Could you kindly guide me how to determine appropriate 
> rng->ops.quality value used by the driver?
> 
> I have tested with rngtest on mtk-cir and the result is got as
> the below log shown.  If the rngtest always gives the result for
> success rate over 99.8%, can I set the rng->ops.quality 998?
> 
> rngtest: starting FIPS tests...
> rngtest: bits received from input: 20000032
> rngtest: FIPS 140-2 successes: 998
> rngtest: FIPS 140-2 failures: 2

No! You'd have to determine the failure threshold of the test and
apply some math to find a lower boundary of your RNG's entropy.

What the quality is for: your RNG produces bits, but not all of them
are completely independent of each other i.e. not completely random.
So you simply lower the quality rating to express the net entropy
contained in the data stream.

	Torsten
