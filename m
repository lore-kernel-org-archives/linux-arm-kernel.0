From: olof@lixom.net (Olof Johansson)
Date: Mon, 4 Nov 2013 10:57:36 -0800
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <5277CD33.6030003@wwwdotorg.org>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <1432962.yW4lKnaQJE@flatron> <25161583.XICaeMWvPh@flatron>
 <2443024.JdDKnfkC18@wuerfel> <5277CD33.6030003@wwwdotorg.org>
Message-ID: <CAOesGMhHH7XENmEVJEbOQX03Zc_Q8775ijUfg5r1fLLGTLUymw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 4, 2013 at 8:37 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> I had suggested that while talking to someone at the kernel summit,
> basically each driver supplies functions like:
>
> 1) ACPI -> platform data or resources converter
> 2) DT -> platform or resources data converter
> 3) anything else -> platform or resources data converter
> 4) probe()
>
> One of (1)..(3) (depending on device instantiation source) is called to
> translate the data source to platform data or resources, before probe
> (and could indeed handle much of deferred probe I suppose).
>
> (4) is called to actually initialize the device, and always has complete
> pre-parsed platform data/resources available, and does no DT/ACPI/...
> parsing.
>
> I forget who I was talking to, but it was asserted something like this
> had been proposed before, and wasn't accepted. Unfortunately, I don't
> entirely recall why...
>
> It may have been due to the fact I proposed (1) and (2) above being
> separate, rather than identical, due to using some unified API to read
> data from ACPI and DT. That wasn't the most interesting aspect of the
> proposal though. Still, I think conceptually there could be other data
> sources in the future, so we may need to allow different types of
> conversion function at some point, even if the ACPI and DT
> implementations can end up being the same.

I think it might have been me you were talking to. I know Grant
considered something like that when first doing the device tree
enablement, and chose not to do it then but I am not sure what the
motivations were. Given that we have cleaned up a lot of driver
probing already by now, it might be suitable to try again.


-Olof
