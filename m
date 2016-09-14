From: sf84@laposte.net (Sebastian Frias)
Date: Wed, 14 Sep 2016 10:24:51 +0200
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <20160913154722.GD23336@leverpostej>
References: <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <57D6D2A9.3010006@laposte.net> <20160912165637.GF14165@leverpostej>
 <57D7CF17.2050905@laposte.net> <20160913131208.GA23336@leverpostej>
 <57D8137F.8040508@laposte.net> <20160913154722.GD23336@leverpostej>
Message-ID: <57D90953.9030701@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 09/13/2016 05:47 PM, Mark Rutland wrote:
>>> If you believe that the bindings don't matter, then there is absolutely
>>> no reason for them to exist in the first place.
>>>
>>> If those binding matter to *anyone*, then those collating the bindings
>>> have some responsibility of stewardship, and that includes
>>> review/maintenance/etc.
>>
>> The thing is that right now it seems the "responsibility of stewardship"
>> lies only within "Linux", whereas DT is proposed as open for everybody,
>> Bootloaders, FreeBSD, etc.
>>
>> In that case, shouldn't the "responsibility" be shared?
> 
> Ideally, yes.
> 
> Which is one of the reasons devicetree.org was set up as a common forum
> for projects to collaborate on devicetree.

I see, what about using different 'sections' on a DT to allow different
parties be responsible for their 'section'?

- 'generic' sections (i.e.: those using bindings used by Linux drivers)
would be under stewardship of Linux.

- 'specific' sections (i.e.: my example, bindings *not used by Linux*, but
they could be bindings for other OSs as you said) would be under a
different stewardship.

DT seems essentially free-form, like XML.
One could imagine that some tool could then be used to guarantee that
some parts of DT conform to a given XML schema, including backwards
compatibility, while at the same time ignoring 'staging'/'specific' stuff.

NOTE: this appears to be possible using 'overlays' as Warner suggested, but
in that case not all parts are public, which limits public information.

Best regards,

Sebastian
