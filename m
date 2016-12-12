From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2016 12:56:48 +0000
Subject: [PATCH 1/1] arm/module: maximum utilization of module area.
In-Reply-To: <20161212112230epcms5p6af05aef34f72eab15061a166d18cff00@epcms5p6>
References: <1481012975-44478-1-git-send-email-maninder1.s@samsung.com>
 <CGME20161212102403epcas4p2e039072e2acdc3d20c1b8ac86e823375@epcas4p2.samsung.com>
 <20161212112230epcms5p6af05aef34f72eab15061a166d18cff00@epcms5p6>
Message-ID: <20161212125648.GU14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2016 at 11:22:30AM +0000, Vaneet Narang wrote:
> Hi,
> 
> >A PC24 relocation has a range of +/-32MB.  This means that where-ever
> >the module is placed, it must be capable of reaching any function
> >within the kernel text, which may itself be quite large (eg, 8MB, or
> >possibly larger).  The module area exists to allow modules to be
> >located in an area where PC24 relocations are able to reach all of the
> >kernel text on sensibly configured kernels, thereby allowing for
> >optimal performance.
> >
> >If you wish to load large modules, then enable ARM_MODULE_PLTS, which
> >will use the less efficient PLT method (which is basically an indirect
> >function call) for relocations that PC24 can't handle, and will allow
> >the module to be loaded into the vmalloc area.
> >
> >Growing the module area so that smaller modules also get penalised by
> >the PLT indirection is not sane.
> 
> This is exactly what i am saying. These changes are useful to accomdate
> 22MB modules without enabling ARM_MODULE_PLTS. 

Obviously I wasn't clear enough.

No, I do not like your change for the reasons given above.  I'm not going
to accept it.

If you want to use 22MB modules, enable ARM_MODULE_PLTS.

Thank you.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
