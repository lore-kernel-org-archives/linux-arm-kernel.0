From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 13 Dec 2013 14:00:30 +0800
Subject: [PATCH v6 04/15] usb: doc: phy-mxs: update binding for adding
 anatop phandle
In-Reply-To: <20131213042504.GE867@saruman.home>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-5-git-send-email-peter.chen@freescale.com>
 <20131213042504.GE867@saruman.home>
Message-ID: <CAL411-rKen4q+Vfn6biO8URWDBfgCuzat0k2SkWoUzAryD_5Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 12:25 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Dec 13, 2013 at 09:23:34AM +0800, Peter Chen wrote:
>> Add anatop phandle which is used to access anatop registers to
>> control PHY's power and other USB operations.
>
> no related to this patch, but this feels like OMAP's System Control
> Module (a rather simplistic IP which control power for a few other IPs).
>
> We're starting to see a pattern here, eventually we will need a more
> generic approach to such types of modules. For now, don't worry :-)
>

We use syscon (system controller) driver (drivers/mfd/syscon.c)
to handle it, syscon uses regmap to visit register which can keep
register access exclusively.

-- 
BR,
Peter Chen
