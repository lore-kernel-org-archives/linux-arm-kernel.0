From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 22 Jun 2012 12:05:44 +0200
Subject: arm erratas (config options)
Message-ID: <4FE44378.9050803@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm currious why there exists config options for the various arm 
erratas. Isn't it possible to identify the variant and revision of the 
cores and enable the necessary workarounds automatically?

And would it be possible to use only one term (at least inside the 
kernel) to describe the arm-variations?

E.g. /proc/cpuinfo talks about variant and revision while all the help 
texts for the erratas are talking about rNpM (which I would translate to 
"revision" and "patch level", without knowing the real meanings).

This makes it necessary to translate "variant" to 'r' and "revision" to 
'p', which isn't really obvious (because most people would translate 
"revision" to 'r' and would wonder how to find the value for 'p' in 
/proc/cpuinfo or somewhere else).

Another source of confusion about which arm erratas should be enabled 
for a specific processor is that not all the help texts for the erratas 
are clear about which variants and revisions are effected. E.g. the help 
texts for erratas 460075 or 458693 are talking about r2p0, but they 
doesn't mention if older variants (e.g. r1p3) get hit by these erratas 
too. The help texts for other erratas (e.g. 743622 and 754322) are 
talking about r2p*, which I would interpret that this errata applies 
only to variant 2, but I would never be sure (reading only the help text).

So without actually reading the erratas (and not only the help texts) I 
assume most people, including me ;) , just don't know if it's necessary 
to enable the workaround for a specific errata (besides that people 
would need to understand whats written in the erratas or help texts itself).

Just enabling all workarounds can't be the answer, otherwise the config 
options for those erratas wouldn't be necessary at all.

Assuming that the list of erratas will grow further, the problem will 
just get worse if nobody defines some rules about how the help texts 
should be written to leave no questions about when one has to enable an 
option.

Just my 2?. ;)

Regards,

Alexander
