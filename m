From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Nov 2013 10:27:40 -0700
Subject: ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <20131119093504.GF31504@ulmo.nvidia.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131118122644.GA26046@ulmo.nvidia.com>
 <20131118134022.26EE7C409EC@trevor.secretlab.ca>
 <20131118135727.GD14306@sirena.org.uk>
 <20131118152920.GL26046@ulmo.nvidia.com>
 <20131118155022.GB28334@sirena.org.uk>
 <20131118160626.GN26046@ulmo.nvidia.com> <528A4B5D.8050809@wwwdotorg.org>
 <20131119093504.GF31504@ulmo.nvidia.com>
Message-ID: <528B9F8C.5080202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 02:35 AM, Thierry Reding wrote:
> On Mon, Nov 18, 2013 at 10:16:13AM -0700, Stephen Warren wrote:
>> On 11/18/2013 09:06 AM, Thierry Reding wrote: ...
>>> Part of my point was that you could possibly still use the same
>>> IP with only a modified (standard) register interface. That way
>>> no licensing of third party IP would be needed. You'd only need
>>> to rewrite parts of the IP to make it look (and behave) like
>>> the standard one.
>>> 
>>> That's exactly how 16550-compatible UARTs work, isn't it? Or
>>> even the way that USB (EHCI, ...) work. There's a standardize
>>> register interface, possibly with a way for vendor-specific
>>> extensions, but the interface itself doesn't need to be
>>> licensed, so there are no additional costs to supporting the
>>> standard interface. There are only the advantages of being able
>>> to reuse a well-tested body of code.
>> 
>> Your idea would be great if it could be made to work in
>> practice.
> 
> This wasn't really my idea, so I can't take all the credit for it.
> =)
> 
>> I'm not convinced how possible this would be, without ARM
>> mandating it in their contractual licensing terms, or large
>> customers mandating it in order to use SoCs for their flagship
>> designs.
> 
> I don't think ARM mandating this is necessary. In the end it boils
> down to faster time to market, doesn't it? I mean if you have a
> device that exposes a standard set of registers and a driver for
> that standard set already exists, then it's very little work to get
> the device working with it. You also save a lot of work on
> validation.

I get the impression that many silicon vendors simply do what they
want when there aren't constraints that dictate otherwise. The
benefits of upstream SW aren't valued by everyone, let alone the
benefits of the HW equivalent - the standardized registers we're
talking about. As such, without some force pushing for
standardization, people won't do it. That force would need to be
either ARM, or the customers/partners/ecosystem consuming the SoCs.

And note that we already have drivers in our product kernels (and
simplified drivers upstream) for all this HW already, so switching
register interface would actually be more work at least in the short term.

Likely the best way to drive this forward is to talk to our silicon
engineers and try and drive this through them. If you can persuade
them, perhaps it can trickle back up to ARM and across other vendors.
If you as an NVIDIA employee can't persuade the NVIDIA HW designers, I
don't expect you could persuade other HW vendors:-)

> The 16550 UART register set wasn't mandated by anyone as far as I
> know, but still the majority of UART devices implement it. I guess
> the same is true of EHCI or SDHCI.

IIUC, the situation is a little different.

A platform existed that used the 8250/16550. That product got into the
market first (or created a new market). Others wanted to be compatible
with the product, so had to implement compatible registers. Thus,
everyone made their motherboard/chipset UARTs work the same.

However, with ARM SoCs, there are multiple tens of vendors all
developing products at once, and even for different markets, so the
whole "must be compatible with this existing thing" driving force
simply doesn't exist, simply because there is no one single "existing
thing". Systems are also larger, and there are many more SW developers
employed, so there's a bit more ability to deal with different HW too.
It may not scale infinitely, but probably better than it did 30 years ago.
