From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jun 2016 16:36:30 +0100
Subject: [PATCH v2 1/3] of: add common OF-based component functionality
In-Reply-To: <CAL_JsqKaRGk6RMdDWUFYH8_J1gp3pcNeuvx-r=JSg7nc6jh_eg@mail.gmail.com>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
 <E1b8pyR-0005OJ-V3@rmk-PC.armlinux.org.uk>
 <CAL_JsqKaRGk6RMdDWUFYH8_J1gp3pcNeuvx-r=JSg7nc6jh_eg@mail.gmail.com>
Message-ID: <20160603153630.GE1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 10:29:40AM -0500, Rob Herring wrote:
> On Fri, Jun 3, 2016 at 9:21 AM, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > Add common OF-based component functionality for matching devices by
> > device node, and releasing the device node at the appropraite time.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/of/Makefile          |  2 +-
> >  drivers/of/of_component.c    | 41 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/of_component.h | 14 ++++++++++++++
> 
> I'd prefer this to go into drivers/base/component.c. That's the
> general direction we've been moving.

I'd prefer not to, I don't want to turn the component helpers into
something OF specific.  They aren't OF specific.

> I'd expect this would cause some build failures unless the cases you
> converted all depend on CONFIG_OF.

Okay, I'll stick with v1 then, and the duplication that v1 involves.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
