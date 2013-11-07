From: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 07 Nov 2013 14:49:53 -0800
Subject: [RFC PATCH 0/4] wire up CPU features to udev based module loading
In-Reply-To: <CAKv+Gu9W-Pu4DGgB-85A3D4Ps9_FLSQgyK3EM7=k7KE1=xsnwg@mail.gmail.com>
References: <1383844657-17487-1-git-send-email-ard.biesheuvel@linaro.org>	<527C0195.50008@zytor.com>	<20131107213944.GJ1962@tassilo.jf.intel.com>
 <CAKv+Gu9W-Pu4DGgB-85A3D4Ps9_FLSQgyK3EM7=k7KE1=xsnwg@mail.gmail.com>
Message-ID: <527C1911.9030900@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2013 02:15 PM, Ard Biesheuvel wrote:
> 
> That would involve repurposing/generalizing a bit more of the existing
> x86-only code than I did the first time around, but if you (as x86
> maintainers) are happy with that, I'm all for it.
> 
> I do have a couple of questions then
> - the module aliases host tool has no arch specific dependencies at
> all except having x86cpu as one of the entries: would you mind
> dropping the x86 prefix there? Or rather add dependencies on $ARCH?
> (If we drop it there, we basically end up with 'cpu:' everywhere)

I think it makes sense to indicate what kind of CPU the string refers
to, as the top-level indicator of what is going on.  This might be
possible to macroize the generation of this prefix, though.

> - in the vendor/family/model case, it may be preferable to drop these
> fields entirely from certain modules' aliases if they match on 'any'
> (provided that the module tools permit this) rather than add
> architecture, variant, revision, etc  fields for all architectures if
> they can only ever match on one

I think that can be CPU dependent.

> - some of the X86_ macros would probable be redefined in terms of the
> generic macros rather than the other way around, which would result in
> some changes under arch/x86 as well, is that acceptable for you?

If you are talking about X86_FEATURE_* then almost certainly no,
although I'm willing to listen to what you have in mind.

	-hpa
