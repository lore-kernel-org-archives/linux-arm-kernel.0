From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 25 Jun 2015 10:46:03 +0200
Subject: [PATCH v3 1/3] leds: netxbig: add device tree binding
In-Reply-To: <558A736D.8030503@samsung.com>
References: <1434639590-27389-1-git-send-email-simon.guinot@sequanux.org>
 <1434639590-27389-2-git-send-email-simon.guinot@sequanux.org>
 <55894D0A.8000306@samsung.com>
 <20150623211711.GF4853@kw.sim.vm.gnt>
 <558A736D.8030503@samsung.com>
Message-ID: <20150625084603.GG4853@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 11:07:57AM +0200, Jacek Anaszewski wrote:
> >>BTW how do you compile the driver? I've tried to use
> >>multi_v5_defconfig and mvebu_v5_defconfig and I have build breaks
> >>with both of them on the recent linux-next.
> >
> >For the original patch set version (Linux 4.0 at the time), I have used
> >the mvebu_v5_defconfig. Now I am using a lighter configuration because
> >I don't need to build the whole mvebu stuff.
> >
> >What kind of error do you get ? I remember something about setting
> >CONFIG_HZ to 250.
> 
> I am getting:
> 
> drivers/crypto/mv_cesa.c:1037:2: error: implicit declaration of
> function ?of_get_named_gen_pool?
> [-Werror=implicit-function-declaration]
> 
> Compilation succeeded after disabling CONFIG_CRYPTO_DEV_MV_CESA.

It is because the merge in linux-next missed the renaming of
of_get_named_gen_pool() in of_gen_pool_get() for the mv_cesa driver.

I have sent a patch, just in case.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150625/19613b06/attachment.sig>
