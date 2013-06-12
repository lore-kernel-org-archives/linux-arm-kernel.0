From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 12 Jun 2013 04:31:26 +0200
Subject: [PATCH v2] ARM: shmobile: uImage load address rework
In-Reply-To: <CANqRtoSoWesMgBmbfUKxeyfwWcKZ77MyckCdPpKwK4WxYynWbA@mail.gmail.com>
References: <20130610092857.19175.25629.sendpatchset@w520>
 <2051721.a0060yLKKU@avalon>
 <CANqRtoSoWesMgBmbfUKxeyfwWcKZ77MyckCdPpKwK4WxYynWbA@mail.gmail.com>
Message-ID: <3243557.sP7VV5jPVm@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Wednesday 12 June 2013 11:21:34 Magnus Damm wrote:
> On Wed, Jun 12, 2013 at 6:50 AM, Laurent Pinchart wrote:
> > On Monday 10 June 2013 18:28:57 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >> 
> >> This is V2 of the mach-shmobile uImage load address rework patch.
> >> 
> >> Rework the mach-shmobile uImage load address calculation by storing
> >> the per-board load addresses in Makefile.boot. This removes the
> >> CONFIG_MEMORY_START dependency from Makefile.boot, and it also makes
> >> it possible to create safe kernel images that boot on multiple boards.
> >> 
> >> This is one of several series of code that reworks code not to rely on
> >> CONFIG_MEMORY_START/SIZE which in turn is needed for ARCH_MULTIPLATFORM.
> >> 
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > I've noticed today that KZM9G doesn't boot v3.10-rc2 with
> > CONFIG_AUTO_ZRELADDR=y. While not caused by this patch, that's something
> > that will need to be fixed to support multi-arch kernels. I'm not too
> > familiar with early boot code, would you be able to have a look at this ?
> 
> I will have a look. I suspect that issue is not related to this patch, is
> it?

No, it isn't, the issue is present in v3.10-rc2. I don't know if it has ever 
worked.

-- 
Regards,

Laurent Pinchart
