From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Jan 2015 20:05:30 +0000
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <1610983.9vqJdsL27R@wuerfel>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <20150107172741.GY2634@sirena.org.uk> <54AD7098.5010700@redhat.com>
 <1610983.9vqJdsL27R@wuerfel>
Message-ID: <20150107200530.GK2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 08:48:48PM +0100, Arnd Bergmann wrote:
> On Wednesday 07 January 2015 12:44:56 Jon Masters wrote:
> > On 01/07/2015 12:27 PM, Mark Brown wrote:

> > > That level of hardware compatibility does partly come from the need to
> > > run existing software.  I'd expect that similar effects will start to
> > > come into play with ARMv8 ACPI systems if they become successful; people
> > > will do things like ensure compatibility with common IPs that have
> > > existing Linux drivers that distros tend to include as standard.

> > Agreed.

> There are two problems I see in trying to do the same thing on ARM:

> * we don't have a single vendor that makes de-facto standards that
>   everyone else has to copy in the way that the few remaining x86
>   vendors copy everything that Intel does. In fact, we prefer to
>   have a large number of independent vendors.

Right, I'd guess that (modulo any standards being defined and becoming
successful) it'll more be a case of vendors keeping compatibility with
their own stuff.  We *are* seeing greater reliance on off the shelf IPs
for more boring things like DMA and basic bus controllers but there's
plenty of other areas that still affect servers.

> * There is a general mindset about deprecating unwanted features
>   early. ARMv8 aarch32 bit mode removes support for older instructions
>   or makes them optional. Even the virtualization mode doesn't allow
>   to trap on architecture version specific differences, so you can't
>   completely emulate an older architecture level.
>   This is nice for implementers but not so much for users that rely
>   on old (mis-)features. It's also not just the CPU core, other
>   components also get easily replaced, like a GICv3 that is not
>   a strict superset of GICv2.

This is indeed worrying, though hopefully the fact that we're already
seeing negative impacts in the app ecosystem for Android will have
focused some minds - once you're talking about full system images it
gets even more fun.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150107/f0e9f2b2/attachment.sig>
