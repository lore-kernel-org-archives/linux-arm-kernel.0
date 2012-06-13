From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 13:46:23 +0000
Subject: [PATCH v5 03/14] ARM: OMAP2+: gpmc: driver migration helper
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998CF2@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
 <4FD6555D.4000508@ti.com> <20120613120457.GO12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998CF2@DBDE01.ent.ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998EFD@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Jun 13, 2012 at 17:48:15, Mohammed, Afzal wrote:
> On Wed, Jun 13, 2012 at 17:34:58, Tony Lindgren wrote:
 
> > There should no longer be any need to initialize GPMC early. It should
> > behave like any other device driver, and also work as a loadable module.
> 
> Once driver migration is complete for all the boards, we can remove the
> initcall and make it loadable.
> 
> But till that time as we need to support both old & new interface,
> I feel this is necessary as old interface would happen in arch initcall,
> and old gpmc_init is now gpmc_probe, and hence it needs to get executed
> before arch initcall, necessitating this.

Seems you missed this in the flood of mails, please let me know your
comments on this. This is a commit that has to be reverted once driver
migration is complete for all boards.

Regards
Afzal
