From: Nathan_Lynch@mentor.com (Lynch, Nathan)
Date: Thu, 8 Feb 2018 16:11:07 +0000
Subject: [VDSO]: vdso_test failing on arm 32 bit
In-Reply-To: <CAOuPNLgj8c0a1gDESQDatoa4GU_PYu8TK1NJ0KKkVfjW7zvsdA@mail.gmail.com>
References: <20171212162612.GB10595@n2100.armlinux.org.uk>
 <1513098352501.51185@mentor.com>
 <20171212172034.GC10595@n2100.armlinux.org.uk>
 <CAOuPNLiTf040ZOyEroq4oy=5Bz1LScmE-vpR3xdjXBGuCKcxMA@mail.gmail.com>
 <20171213111718.GJ10595@n2100.armlinux.org.uk>
 <CAOuPNLgM8OxP8cV9goAUDtXgxjhcfoe27M0Q=Ty1BVAPD5aipQ@mail.gmail.com>
 <20171213171530.GM10595@n2100.armlinux.org.uk>
 <1513186632784.96495@mentor.com>
 <20171213173956.GN10595@n2100.armlinux.org.uk>
 <CAOuPNLgZL0N0OuTUEVR6vFjykBtLeR+t0pvn3FSKsA4UqG-UGQ@mail.gmail.com>
 <20171214102148.GO10595@n2100.armlinux.org.uk>,
 <CAOuPNLgj8c0a1gDESQDatoa4GU_PYu8TK1NJ0KKkVfjW7zvsdA@mail.gmail.com>
Message-ID: <1518106267799.61329@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I commented the device tree reading property:
> arm,cpu-registers-not-fw-configured , from the arch/arm/kernel/vdso.c

Don't do that, please. The presence of that property indicates that the counter is not suitable for use by the OS. There is nothing we can do in Linux to make the VDSO useful on this system; that is why it gets disabled at runtime.

The timing measurements you get are likely tainted by garbage results from the VDSO itself.
