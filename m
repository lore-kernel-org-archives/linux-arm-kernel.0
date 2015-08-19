From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 19 Aug 2015 10:17:57 +0200
Subject: [PATCH v2 0/6] ARM: berlin: add cpufreq support
In-Reply-To: <20150818145925.GF31148@linux>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
 <CAOh2x=ke9NWa-GjL=c+RgEWWfsNeKvE2O9CRHmW2dG5mj8ATCg@mail.gmail.com>
 <20150818143911.GB12017@kwain> <20150818145925.GF31148@linux>
Message-ID: <20150819081757.GA1089@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 08:29:25PM +0530, Viresh Kumar wrote:
> On 18-08-15, 16:39, Antoine Tenart wrote:
> > However, it seems the OPP-v2 table takes precedence over the old one.
> > When a default OPP-v2 table is supplied in the device tree, if the
> > bootloader supplies an OPP table the old way it won't be taken into
> > account.
> > 
> > So if I understood correctly, this won't work here for the BG2Q.
> 
> Didn't understood it completely. Are you saying that your dtb will
> have two operating-points tables ?

Yes. If the device tree has an OPP-v2 table and the bootloader modify it
to add an old OPP table at boot, the one added by the bootloader won't
be taken into account by the kernel.

> The deal is that for any device, parsing of opp-v2 will be attempted
> first. If its not available, then opp-v1 will be tried. But this is
> per-device. So, one device can have opp-v2 tables and other one can do
> v1 type.

Sure. OPP-v2 tables can be used for devices having an up-to-date
bootloader or if the bootloader do not modify the device tree at boot
time to add an (old) OPP table.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
