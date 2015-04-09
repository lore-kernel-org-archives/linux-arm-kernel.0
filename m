From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Apr 2015 16:34:33 +0100
Subject: [PATCH] coresight: etb10: Print size of buffer we fail to allocate
In-Reply-To: <CANLsYkzKJM0c4cw9=6bi=ZQYk9K6f-BLm7bSoUKUjgVNS5K_VA@mail.gmail.com>
References: <1428531327-16902-1-git-send-email-broonie@kernel.org>
 <CANLsYkzoj5nPs2dnejOsDgEHZXArbXq5s6B7Cp3P1siu0Vv8YA@mail.gmail.com>
 <20150409145558.GW6023@sirena.org.uk>
 <CANLsYkzKJM0c4cw9=6bi=ZQYk9K6f-BLm7bSoUKUjgVNS5K_VA@mail.gmail.com>
Message-ID: <20150409153433.GY6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 09:14:40AM -0600, Mathieu Poirier wrote:
> On 9 April 2015 at 08:55, Mark Brown <broonie@kernel.org> wrote:

> > This depends on what the hardware does and how the device is registered
> > - if the device is registered with an ID provided (which you can do)
> > then AMBA won't bother reading the ID back and verifying that it's
> > correct so there's no interaction with the hardware until we hit the
> > driver.

> Indeed possible, but in that case you'll get a core dump or the kernel
> will simply hang waiting on the memory area being read.

That's the "depends on what the hardware does" bit - some will either
read back nonsense or some predictable but undesirable value like all
1s.

> > I've not checked the DT case, though it doesn't seem like there's any
> > check that the compatible string matches the ID read from the hardware
> > which is a bit interesting...

> This is something I've been meaning to add for a while now but never
> got around to do it.

Yeah, and it's not clear what the best thing to do is - should we be
using the DT to fix up problems in the hardware or should we be
verifying that people got the DT right?  Usually it's the former...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/7078512a/attachment.sig>
