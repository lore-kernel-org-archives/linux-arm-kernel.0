From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 21 Nov 2013 18:23:07 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <201311182247.03540.david.goodenough@btconnect.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.
 com> <20131118190929.GA5886@quad.lixom.net> <20131118213256.8EC15C401C6@
 trevor.secretlab.ca> <201311182247.03540.david.goodenough@btconnect.com>
Message-ID: <20131121182307.47735C406A3@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013 22:47:03 +0000, David Goodenough <david.goodenough@btconnect.com> wrote:
> On Monday 18 Nov 2013, Grant Likely wrote:
> > I fully support getting ACPI up on ARM and the current work is good.
> > However, it cannot short-circuit the kernel development process.
> > Absolutely, push back hard on the ACPI and UEFI patches where the code
> > is not ready.
> 
> Would it not be possible to have ACPI read the hardware configuration
> from the DT, and provide whatever services it wants, while also allowing
> the kernel to retain the DT for its hardware config?  I suppose the only
> thing that would be needed would be some way to mark paricular bits of
> hardware (I am largely thinking of the things lmsensors deals with) as
> being used by ACPI and being off limits to the kernel.

I don't think there's a lot of interesting work there. It is more
interesting to me to boot DT-only for production, but be able to use
those same systems to develop and mature the ACPI support as quickly as
possible. That is essentially what is being done right now by the Linaro
ACPI team on the Versatile Express.

g.
