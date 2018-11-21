From: sugaya.taichi@socionext.com (sugaya.taichi at socionext.com)
Date: Wed, 21 Nov 2018 04:07:19 +0000
Subject: [PATCH 03/14] ARM: milbeaut: Add Milbeaut M10V early printk
In-Reply-To: <CAL_JsqKMK7nMUxZLu9eV8tpnCXsAr2F4j=xTO8UL0g8V30kYZg@mail.gmail.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-4-git-send-email-sugaya.taichi@socionext.com>
 <CAL_JsqKMK7nMUxZLu9eV8tpnCXsAr2F4j=xTO8UL0g8V30kYZg@mail.gmail.com>
Message-ID: <7f32b467a1d84987b9d80cdd540e035b@SOC-EX02V.e01.socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

Thank you for your comment.

> -----Original Message-----
> From: Rob Herring [mailto:robh+dt at kernel.org]
> Sent: Tuesday, November 20, 2018 12:21 AM
> To: Sugaya, Taichi/?? ??
> Cc: linux-clk; devicetree at vger.kernel.org; moderated list:ARM/FREESCALE
> IMX / MXC ARM ARCHITECTURE; linux-kernel at vger.kernel.org; open list:SERIAL
> DRIVERS; Michael Turquette; Stephen Boyd; Mark Rutland; Greg Kroah-Hartman;
> Daniel Lezcano; Thomas Gleixner; Russell King; Jiri Slaby; Masami Hiramatsu;
> Jassi Brar
> Subject: Re: [PATCH 03/14] ARM: milbeaut: Add Milbeaut M10V early printk
> 
> On Sun, Nov 18, 2018 at 7:00 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
> >
> > Add Milbeaut M10V earlyprintk.
> 
> Do you really need earlyprintk? earlycon is preferred instead. It's
> not quite as early, but doesn't require rebuilding the kernel and
> supports more than 1 fixed device. If you crash before earlycon is
> enabled, that pretty much means either a bad dtb memory node or just
> flaky memory.
OK. I use earlycon since would like to use flexible functions.

Thanks
Sugaya Taichi

> 
> Rob
