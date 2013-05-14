From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 14 May 2013 09:48:54 +0100
Subject: [PATCH 6/9] ARM: ux500: Provide device enumeration number suffix
 for SMSC911x
In-Reply-To: <CACRpkdYz0HcdBovoJu6O-4QyRbXz93MaeWwAwCohbE8rv=8O7Q@mail.gmail.com>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYz0HcdBovoJu6O-4QyRbXz93MaeWwAwCohbE8rv=8O7Q@mail.gmail.com>
Message-ID: <20130514084854.GF3297@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 May 2013, Linus Walleij wrote:

> On Wed, May 8, 2013 at 3:29 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > First Ethernet device has a ".0" appended onto the device name. It
> > appears that we need this in order to obtain the correct clock.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> (...)
> > -       OF_DEV_AUXDATA("smsc,lan9115", 0x50000000, "smsc911x", NULL),
> > +       OF_DEV_AUXDATA("smsc,lan9115", 0x50000000, "smsc911x.0", NULL),
> 
> I guess what you want to say in the commit message is that
> on a non-DT boot the ethernet will be named "smsc911x.0"
> and since the clocks are not converted to device tree these
> names need to be matched when providing the name from
> auxdata.
> 
> Edited the commit message and applied!

Thanks for the effort. :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
