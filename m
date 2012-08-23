From: jett.zhou@gmail.com (jett zhou)
Date: Thu, 23 Aug 2012 17:06:22 +0800
Subject: [V4 3/4] power_supply: Enable battery-charger for 88pm860x
In-Reply-To: <20120823044348.GA415@lizard>
References: <20120714081254.GD20018@lizard>
 <1343377636-16128-1-git-send-email-jtzhou@marvell.com>
 <20120823034815.GB16674@lizard> <20120823044348.GA415@lizard>
Message-ID: <CACDDiy-ZzUxi4MvjELwHzYC+AxF0b0+LuOh=JdFBBgSA2ijjNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anton
    Thanks for helping me to amend these patch.
    I got many good suggestions and learn a lot in this process:)
    BTW, you mean you will help to amend that several minor warning with
battery tree?
    If there is something wrong, I can correct it.

Thanks



2012/8/23 Anton Vorontsov <anton.vorontsov@linaro.org>

> On Wed, Aug 22, 2012 at 08:48:15PM -0700, Anton Vorontsov wrote:
> [....]
> > drivers/mfd/88pm860x-core.c:803:53: warning: incorrect type in
> assignment (different base types)
> > drivers/mfd/88pm860x-core.c:803:53:    expected struct charger_regulator
> *charger_regulators
> > drivers/mfd/88pm860x-core.c:803:53:    got struct regulator_bulk_data
> static [toplevel] *
> >
> > They are minor, except for the last one. You seemed to use
> > 'regulator_bulk_data' struct (just as charger manager documentation
> > wrongly tells you, yup), but in real it should have been
> > 'struct charger_regulator'. The only reason that it worked is
> > because both 'supply' and 'regulator_name' struct members are the
> > first in these structs. :-)
>
> Oh, actually, I see that this is a result of extcon rework, so not
> your fault at all.
>
> Anton.
>



-- 

----------------------------------
Best Regards
Jett Zhou
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/47533a24/attachment-0001.html>
