From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Sep 2016 00:44:05 +0200
Subject: next-20160929 build: 2 failures 4 warnings (next-20160929)
In-Reply-To: <57ED66CA.3090903@akamai.com>
References: <E1bpZhb-0002Oz-OQ@optimist>
 <20160929184737.ragquwy2tmhxo5bn@sirena.org.uk> <57ED66CA.3090903@akamai.com>
Message-ID: <201609300044.05324.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 September 2016, Vishwanath Pai wrote:
> I have sent a patch for this a couple of days ago to netdev, it hasn't
> made it to net-next yet. Here's the latest one:
> 
> [PATCH net-next v3] netfilter: xt_hashlimit: Fix link error in 32bit
> arch because of 64bit division
> 
> This should fix the link error.

I also did a patch (not submitted yet), but my solution used 32-bit
math for the version 1 case. I think that would be better so we
don't slow down 32-bit architectures too much (div_u64_u64
is very slow).

	Arnd
