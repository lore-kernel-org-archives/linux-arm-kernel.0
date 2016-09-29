From: vpai@akamai.com (Vishwanath Pai)
Date: Thu, 29 Sep 2016 15:08:58 -0400
Subject: next-20160929 build: 2 failures 4 warnings (next-20160929)
In-Reply-To: <20160929184737.ragquwy2tmhxo5bn@sirena.org.uk>
References: <E1bpZhb-0002Oz-OQ@optimist>
 <20160929184737.ragquwy2tmhxo5bn@sirena.org.uk>
Message-ID: <57ED66CA.3090903@akamai.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/2016 02:47 PM, Mark Brown wrote:
> On Thu, Sep 29, 2016 at 12:40:35PM +0100, Build bot for Mark Brown wrote:
> 
> For the past couple of days -next has been failing to build an ARM
> allmodconfig due to:
> 
>> 	arm-allmodconfig
>> ERROR: "__aeabi_uldivmod" [net/netfilter/xt_hashlimit.ko] undefined!
> 
> which appears to be triggered by 11d5f15723c9 (netfilter: xt_hashlimit:
> Create revision 2 to support higher pps rates) introducing a division of
> a 64 bit number which should be done using do_div().
> 

I have sent a patch for this a couple of days ago to netdev, it hasn't
made it to net-next yet. Here's the latest one:

[PATCH net-next v3] netfilter: xt_hashlimit: Fix link error in 32bit
arch because of 64bit division

This should fix the link error.

-Vishwanath
