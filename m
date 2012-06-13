From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 06:25:00 +0000
Subject: [PATCH v5 01/14] ARM: OMAP2+: gpmc: platform definitions
In-Reply-To: <4FD79147.9060501@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <139eb951817b4bee8ea91083b0d572c7421078f0.1339419492.git.afzal@ti.com>
 <4FD79147.9060501@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99889E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jun 13, 2012 at 00:28:15, Hunter, Jon wrote:
> On 06/11/2012 09:26 AM, Afzal Mohammed wrote:

> > +enum {
> > +	has_none,
> > +	has_period,
> > +	has_clock
> > +};
> > +
> > +struct gpmc_time_ctrl {
> > +	int type;
> > +	struct gpmc_timings timings;
> > +	struct gpmc_misc_timings bool_timings;
> > +};
> 
> Why not combine misc_timings and the original timings? I don't see why
> these need to be kept separate. Even if combined it can still be

To keep similar things together, as misc_timings are all bool type, while
existing are not so. This could have been put inside gpmc_timings, but
wanted to reduce chance of issues for users of old interface.

> backward compatible for legacy boards as they will not specify the misc
> timing fields. I am also not convinced we need this type member.

Reason: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg69041.html

Regards
Afzal
