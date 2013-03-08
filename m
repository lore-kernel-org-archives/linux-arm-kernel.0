From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 8 Mar 2013 00:59:43 +0000
Subject: [PATCH v5 01/16] spi/spi-atmel: fix master->num_chipselect
 wrongly set.
In-Reply-To: <20130302231535.8E6043E35BE@localhost>
References: <1361861289-30332-1-git-send-email-wenyou.yang@atmel.com>
 <1361861289-30332-2-git-send-email-wenyou.yang@atmel.com>
 <20130302231535.8E6043E35BE@localhost>
Message-ID: <B256D81BAE5131468A838E5D7A2436414971AE03@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Grant Likely [mailto:glikely at secretlab.ca] On Behalf Of Grant Likely
> Sent: 2013?3?3? 7:16
> To: Yang, Wenyou; linux-arm-kernel at lists.infradead.org
> Cc: Ferre, Nicolas; plagnioj at jcrosoft.com; richard.genoud at gmail.com; Lin, JM;
> Yang, Wenyou; spi-devel-general at lists.sourceforge.net;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v5 01/16] spi/spi-atmel: fix master->num_chipselect
> wrongly set.
> 
> On Tue, 26 Feb 2013 14:47:54 +0800, Wenyou Yang <wenyou.yang@atmel.com>
> wrote:
> > if the spi property "cs-gpios" is set as below:
> >
> > 	cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
> >
> > the master->num_chipselect will wrongly be set to 0,
> > and the spi fail to probe.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Cc: spi-devel-general at lists.sourceforge.net
> > Cc: linux-kernel at vger.kernel.org
> 
> I think I've got this bug fixed in the core spi code. Give it a couple
> of days and retest with linux-next.
Hi Grant,

Yes, in v3.9-rc1 this bug fixed, I retested on v3.9-rc1.
But on "spi/next" git tree, it should to apply this patch.

I sent the patches version 6, could you take a look them? 
Thanks a lot for your work.

> 
> g.

Best Regards,
Wenyou Yang
