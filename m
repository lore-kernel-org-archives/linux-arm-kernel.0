From: rjui@broadcom.com (Ray Jui)
Date: Mon, 9 Mar 2015 12:00:10 -0700
Subject: [PATCH v5 3/8] pinctrl: cygnus: add initial IOMUX driver support
In-Reply-To: <1425926456.2317.13.camel@tiscali.nl>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>	
 <1425515756-321-4-git-send-email-rjui@broadcom.com>	
 <1425542612.24292.180.camel@x220>	
 <CACRpkdYTDSSSd5oDNXmcav-2ycbki0=K+0Cm6dLSBHUv6UXF9g@mail.gmail.com>
 <1425926456.2317.13.camel@tiscali.nl>
Message-ID: <54FDEDBA.1070404@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/9/2015 11:40 AM, Paul Bolle wrote:
> Linus Walleij schreef op ma 09-03-2015 om 17:28 [+0100]:
>> I think you're right. Or I fear you're right.
>>
>> But this problem is present in so many drivers that a generic
>> fixup needs to be done with a script and across an entire subsystem
>> at once,
> 
> Why don't we start with checking for similar cases during review, like
> I'm now doing for only a week or two?
> 
>>  and besides I'm not sure of these macros disturb so much.
> 
> I think they're confusing at best. Ie, when reading the code and the
> corresponding Kconfig file one has to wonder: should the Kconfig symbol
> actually be tristate or should it stay bool but did someone forget to
> delete the module-specific code?
> 
>> They are documentation in a sense, albeit a kind of documentation
>> we used before we had git to record the actual authors of the
>> code.
> 
> They're useful, mostly, for module utilities. Outside that scope they
> add information that thousands of files (that can also only be built-in
> but do not have these macros) do not have and, apparently, do not need.

I think it depends on how you see it. Based on this logic, then one can
also argue comments in the code will be pre-processed away and are not
needed. They at least serve the same documentation purpose in a way. So
far I haven't seen other people complaining that having these module
based macros in the driver are confusing when the Kconfig has a bool.

Ray

> 
> Thanks,
> 
> 
> Paul Bolle
> 
