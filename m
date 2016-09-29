From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Sep 2016 11:47:37 -0700
Subject: next-20160929 build: 2 failures 4 warnings (next-20160929)
In-Reply-To: <E1bpZhb-0002Oz-OQ@optimist>
References: <E1bpZhb-0002Oz-OQ@optimist>
Message-ID: <20160929184737.ragquwy2tmhxo5bn@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 12:40:35PM +0100, Build bot for Mark Brown wrote:

For the past couple of days -next has been failing to build an ARM
allmodconfig due to:

> 	arm-allmodconfig
> ERROR: "__aeabi_uldivmod" [net/netfilter/xt_hashlimit.ko] undefined!

which appears to be triggered by 11d5f15723c9 (netfilter: xt_hashlimit:
Create revision 2 to support higher pps rates) introducing a division of
a 64 bit number which should be done using do_div().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160929/faf6b914/attachment.sig>
