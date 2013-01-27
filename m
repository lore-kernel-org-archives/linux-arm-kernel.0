From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Jan 2013 18:17:17 +0100
Subject: [PATCH v3 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <CAKohponWS73JtB3Vwk5bR=+UcT2tfrKsAmHCJEW9DqobkuYgmQ@mail.gmail.com>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-2-git-send-email-andrew@lunn.ch>
 <CAKohpomWM41MhRjdhFixy-ELXc6QjE0BhCAHfTzovOD0CBPoOQ@mail.gmail.com>
 <20130127154212.GJ29973@lunn.ch>
 <CAKohpomQJfsWBY5o3ep4r86fYYQ39JnMPswjoe8YFT37ekM20w@mail.gmail.com>
 <20130127162523.GK29973@lunn.ch>
 <CAKohponWS73JtB3Vwk5bR=+UcT2tfrKsAmHCJEW9DqobkuYgmQ@mail.gmail.com>
Message-ID: <20130127171717.GL29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 10:15:18PM +0530, Viresh Kumar wrote:
> On 27 January 2013 21:55, Andrew Lunn <andrew@lunn.ch> wrote:
> > So when we have a multiplatform kernel with many of these drivers
> > built in, all but one are going to notice they are not on the hardware
> > they support, and return -ENODEV.
> >
> > By making it a platform driver, the kirkwood cpufreq driver will only
> > get loaded on kirkwood systems, and won't slow down the boot for
> > everybody else.
> 
> I tried to grep platform_driver in drivers/cpufreq/ and got only:
> drivers/cpufreq/dbx500-cpufreq.c
> 
> Now, the counter argument to your explanation is, multiplatform kernel would be
> built only for testing purpose and not for real product.

I expect Debian, Fedora etc will strongly disagree with you
there. They want one kernel that will run on as many products they
support as possible. Kirkwood is mostly used in NAS boxes and is
supported by all these distributions.

Now for a SoC used in a deeply embedded system, using a custom
distribution, buildroot, etc, multiplatform is probably not
wanted. But the products i've seen using Kirkwood don't fit this use
case.

> So, even this kind of delay is really not a big issue. On the other
> hand with platform driver too, we will hit lot of other code and
> would consume some extra memory for keeping its structures

Kirkwood has many platform drivers, all this code is already pulled
in, lots of structures already exist. The incremental costs of another
platform device is minimal.

   Andrew
