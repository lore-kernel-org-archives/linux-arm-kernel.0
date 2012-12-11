From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Dec 2012 10:01:38 -0800
Subject: Errata on multiplatform kernels
In-Reply-To: <CAOesGMjJ=y4J70CaYYaEem0ni7Vb48KuEZKxaVYuCCCoMYwjPw@mail.gmail.com>
References: <1355203223.16750.2.camel@gitbox>
 <CAOesGMjJ=y4J70CaYYaEem0ni7Vb48KuEZKxaVYuCCCoMYwjPw@mail.gmail.com>
Message-ID: <20121211180138.GB4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [121210 21:38]:
> Hi,
> 
> On Mon, Dec 10, 2012 at 9:20 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
> > How are errata handled on multiplatform kernels?
> >
> > There don't appear to be any errata selected by default in any of the
> > current multiplatform options, but presumably it will happen eventually.
> >
> > Does that mean the errata will be applied to all machines that boot with
> > the errata selected, even if not required?
> 
> Yes. To date I believe most errata we have are just performance hits
> on platforms that don't need it.
> 
> Other architectures have in some cases added runtime patching (out) of
> workarounds that aren't needed on the current platform for the ones
> that have significant performance impact. I'm guessing we'll end up
> with something similar eventually but until then we'll try to just go
> with the superset of needed errata.

We can't enable any of the errata if there's a chance that it will behave
in a different way for secure mode devices compared to non-secure devices.

The discussion is in the thread "[PATCH] ARM: Fix errata 751472 handling
on Cortex-A9 r1p*".

The conclusion was that we cannot enable any errata for multiplatform,
and must assume the errata is handled by the bootloader. Multiplatform
image is already broken for at least omap4 as 751472 is selected.

Regards,

Tony
