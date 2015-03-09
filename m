From: rjui@broadcom.com (Ray Jui)
Date: Mon, 9 Mar 2015 12:40:30 -0700
Subject: [PATCH v5 3/8] pinctrl: cygnus: add initial IOMUX driver support
In-Reply-To: <1425929442.2317.39.camel@tiscali.nl>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>		
 <1425515756-321-4-git-send-email-rjui@broadcom.com>		
 <1425542612.24292.180.camel@x220>		
 <CACRpkdYTDSSSd5oDNXmcav-2ycbki0=K+0Cm6dLSBHUv6UXF9g@mail.gmail.com>	
 <1425926456.2317.13.camel@tiscali.nl> <54FDEDBA.1070404@broadcom.com>
 <1425929442.2317.39.camel@tiscali.nl>
Message-ID: <54FDF72E.2010806@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/9/2015 12:30 PM, Paul Bolle wrote:
> Ray Jui schreef op ma 09-03-2015 om 12:00 [-0700]:
>> I think it depends on how you see it. Based on this logic, then one can
>> also argue comments in the code will be pre-processed away and are not
>> needed. They at least serve the same documentation purpose in a way.
> 
> So why not make them comments? And even that might not be needed:
> - MODULE_LICENSE() only summarizes, in just a few words, what takes a
> few paragraphs in the customary comment at the top of a file;
> - MODULE_DESCRIPTION() repeats what, in general, has been said in the
> Kconfig entry for that driver and in the git commit explanation;
> - and I'm not sure what the benefit is of MODULE_AUTHOR() in the first
> place (even for actually modular drivers).
> 
>> So
>> far I haven't seen other people complaining that having these module
>> based macros in the driver are confusing when the Kconfig has a bool.
> 
> Perhaps that's just because review doesn't spot all issues. Patch
> bandwidth exceeding review bandwidth and all that.

I don't see this as an "issue" to be quite honest. By saying that, I at
least agree with you that these are not information that's mandatory to
be in the driver given what we already have. MODULE_LICENSE is covered
by license header. MODULE_DESCRIPTION is covered by descriptions in
Kconfig. MODULE_AUTHOR is much less important than what's in the
MAINTAINERS list.

Since I have to submit a new patch series to address the "ngpios" issue
that Linus mentioned in the other email, I don't mind removing all these
MODULE_* macros in the driver all together.

> 
> Anyhow, right now there's another thread discussing the questions my
> review comments raise. Eg, "The Kconfig symbol is bool, there is module
> related code in the driver, why note make the Kconfig symbol tristate
> (and the driver modular)?". I think that is one of the questions mixing
> built-in and modular semantics raises.
> 
> 
> Paul Bolle
> 

Thanks,

Ray
