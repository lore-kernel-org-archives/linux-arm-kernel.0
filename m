From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Sep 2014 14:49:37 +0100
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <540C83DE.10505@collabora.co.uk> <540C8577.2070907@gmail.com>
 <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
Message-ID: <20140908134937.GK4015@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 01:20:11PM +0100, Grant Likely wrote:
> On Mon, Sep 8, 2014 at 12:21 PM, Will Deacon <will.deacon@arm.com> wrote:

> > Whilst I'm sympathetic to people working to enable DRM, I think this is
> > the right solution to the problem. The transition from simplefb to DRM
> > shouldn't break display for a bunch of kernel revisions whilst the code is
> > in flux.

> I would go further. The kernel behaviour has changed, and we have to
> deal with platforms that assume the old behaviour. That means either
> defaulting to leaving enabled regulators/clocks alone unless there is
> a flag in the DT saying they can be power managed, or black listing
> platforms that are known to depend on the regulator being on.

For regulators there is essentially a flag in DT already - the
regulators should not be described in DT if the OS isn't supposed to be
managing them.

> Updating the device tree must not be required to get the kernel to
> boot, but it is valid to require a DT upgrade to get better
> performance (battery life) out of the platform.

This has got to be a blacklist then, and it seems like we've got to fix
simplefb to actually support managing the resources it's using.  The
current plan does not seem at all sensible - we're talking about adding
hacks in every subsystem that provides resources and bodging DTs in
order to work around simplefb.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140908/917aadaa/attachment.sig>
