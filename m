From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 May 2014 15:36:01 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <CACRpkdaqsVUDA+6NC=EQmxcnDAnJEfPNYoptrEv=nq=eZEbA_g@mail.gmail.com>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <CAL_JsqLN_f1uvrY6w7J7ZcR9pfM0_XKYMQ5YU8F4yAcMW+oDGw@mail.gmail.com>
 <CACRpkdaqsVUDA+6NC=EQmxcnDAnJEfPNYoptrEv=nq=eZEbA_g@mail.gmail.com>
Message-ID: <5376959.IId6jNFDDg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014 15:30:39 Linus Walleij wrote:
> >> +       parent = soc_device_to_device(soc_dev);
> >
> > We really need to standardize this soc device stuff so that platforms
> > always have a parent soc device or not.
> 
> Arnds position is that the entire platform/board should not be
> a "soc device" and that seems correct since the board is no SoC.
> 
> So I will spin this off into a SoC driver and push under
> drivers/soc and bind to the SoC node in the device tree.

To be clear, this has nothing to do with whether this is strictly a SoC
or not. I would still want to see all the internal components of the
main chip under the soc node, and probably anything that is attached
to one of its interfaces under those nodes. The parts that should not
be under /soc are the ones that are not in the device hierarchy, such
as external clock generators.

	Arnd
