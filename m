From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 18 Aug 2015 16:39:11 +0200
Subject: [PATCH v2 0/6] ARM: berlin: add cpufreq support
In-Reply-To: <CAOh2x=ke9NWa-GjL=c+RgEWWfsNeKvE2O9CRHmW2dG5mj8ATCg@mail.gmail.com>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
 <CAOh2x=ke9NWa-GjL=c+RgEWWfsNeKvE2O9CRHmW2dG5mj8ATCg@mail.gmail.com>
Message-ID: <20150818143911.GB12017@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 18, 2015 at 06:26:42PM +0530, Viresh Kumar wrote:
> On Tue, Aug 18, 2015 at 5:16 PM, Antoine Tenart
> <antoine.tenart@free-electrons.com> wrote:
> >
> > This series adds the cpufreq support to the Berlin SoCs, using
> > cpufreq-dt.
> >
> > First, the cpuclk clock is added to the BG2Q clock driver. This clock
> > has a divider fixed to 1, so we use a fixed factor clock here.
> >
> > Then register a platform device for cpufreq-dt.
> >
> > I also added the OPP table definition in the BG2Q, BG2 and BG2CD device
> > trees. When using a BG2Q, some bootloaders may update this table when
> > booting (mine doesn't).
> 
> You can switch to OPP-v2 bindings if you want. Just have a look, they are
> much more powerful.. Should be in linux-next/master.

Nice!

However, it seems the OPP-v2 table takes precedence over the old one.
When a default OPP-v2 table is supplied in the device tree, if the
bootloader supplies an OPP table the old way it won't be taken into
account.

So if I understood correctly, this won't work here for the BG2Q.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
