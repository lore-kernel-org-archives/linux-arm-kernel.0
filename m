From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Fri, 20 Jul 2018 19:55:42 +0200
Subject: [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use gpio-omap accessors
 for data I/O
In-Reply-To: <20180719081508.5dafebde@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180719081508.5dafebde@bbrezillon>
Message-ID: <6335220.Jscgez8sxx@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Thursday, July 19, 2018 8:15:08 AM CEST Boris Brezillon wrote:
> Hi Janusz,
> 
> On Thu, 19 Jul 2018 01:57:02 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Implement the idea suggested by Artem Bityutskiy and Tony Lindgren
> > described in commit b027274d2e3a ("mtd: ams-delta: fix
> > request_mem_region() failure").
> 
> Thanks for doing that. I'll review the patches, but I already have a
> extra request: can you convert this driver to ->exec_op()? It does not
> necessarily have to be done in this patchset, but, that'd be great to
> have one more driver converted to the new interface.

OK, I'll have a look as my free time permits.

> BTW, there seems to be a nand_gpio driver, maybe we should merge
> ams-delta code into nand_gpio after it's been patched to use the GPIO
> consumer API.

nand_gpio uses a form of read()/write() on a single bidirectional register for 
data transfer, not GPIO, and it does not make use of NRE / NWE signals.  Maybe 
the two drivers could be merged to some extent but not entirely, I think.

Thanks,
Janusz
