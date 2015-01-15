From: linda.knippers@hp.com (Linda Knippers)
Date: Thu, 15 Jan 2015 11:45:32 -0600
Subject: [Linaro-acpi] [RFC] ACPI on arm64 TODO List
In-Reply-To: <54B5C4B4.30708@redhat.com>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <CACxGe6vRN2Tc97=Sx05gri02goxBaHnZm30hR37q=002agFLAA@mail.gmail.com>
 <CACxGe6sbGu53x5rsx2sWVVVVCnnFvmkQAk3Se9ZGNOXCkqpi=A@mail.gmail.com>
 <20150112142358.GA23680@amd>
 <CACxGe6ub0UsUNs1-2NziK_sGEtpxTjcDD+Eto3YOsNkvWxaNcw@mail.gmail.com>
 <20150112193905.GB5281@amd> <54B5C4B4.30708@redhat.com>
Message-ID: <54B7FCBC.20305@hp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/13/2015 7:21 PM, Al Stone wrote:
> On 01/12/2015 12:39 PM, Pavel Machek wrote:
>> On Mon 2015-01-12 14:41:50, Grant Likely wrote:
>>> On Mon, Jan 12, 2015 at 2:23 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>>> On Sat 2015-01-10 14:44:02, Grant Likely wrote:
>>>>> On Wed, Dec 17, 2014 at 10:26 PM, Grant Likely <grant.likely@linaro.org> wrote:
>>>>>> On Tue, Dec 16, 2014 at 11:27 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>>>> On Monday 15 December 2014 19:18:16 Al Stone wrote:
>>>>>>>> 7. Why is ACPI required?
>>>>>>>>    * Problem:
>>>>>>>>      * arm64 maintainers still haven't been convinced that ACPI is
>>>>>>>>        necessary.
>>>>>>>>      * Why do hardware and OS vendors say ACPI is required?
>>>>>>>>    * Status: Al & Grant collecting statements from OEMs to be posted
>>>>>>>>      publicly early in the new year; firmware summit for broader
>>>>>>>>      discussion planned.
>>>>>>>
>>>>>>> I was particularly hoping to see better progress on this item. It
>>>>>>> really shouldn't be that hard to explain why someone wants this feature.
>>>>>>
>>>>>> I've written something up in as a reply on the firmware summit thread.
>>>>>> I'm going to rework it to be a standalone document and post it
>>>>>> publicly. I hope that should resolve this issue.
>>>>>
>>>>> I've posted an article on my blog, but I'm reposting it here because
>>>>> the mailing list is more conducive to discussion...
>>>>>
>>>>> http://www.secretlab.ca/archives/151
>>>>
>>>> Unfortunately, I seen the blog post before the mailing list post, so
>>>> here's reply in blog format.
>>>>
>>>> Grant Likely published article about ACPI and ARM at
>>>>
>>>> http://www.secretlab.ca/archives/151
>>>>
>>>> . He acknowledges systems with ACPI are harder to debug, but because
>>>> Microsoft says so, we have to use ACPI (basically).
>>>
>>> Please reread the blog post. Microsoft is a factor, but it is not the
>>> primary driver by any means.
>>
>> Ok, so what is the primary reason? As far as I could tell it is
>> "Microsoft wants ACPI" and "hardware people want Microsoft" and
>> "fragmentation is bad so we do ACPI" (1) (and maybe "someone at RedHat
>> says they want ACPI" -- but RedHat people should really speak for
>> themselves.)
> 
> I have to say I found this statement fascinating.
> 
> I have been seconded to Linaro from Red Hat for over two years now,
> working on getting ACPI running, first as a prototype on an ARMv7 box,
> then on ARMv8.  I have been working with Grant since very early on when
> some of us first started talking about ARM servers in the enterprise
> market, and what sorts of standards, if any, would be needed to build an
> ecosystem.
> 
> This is the first time in at least two years that I have had someone
> ask for Red Hat to speak up about ACPI on ARM servers; it's usually
> quite the opposite, as in "will you Red Hat folks please shut up about
> this already?" :).
> 
> For all the reasons Grant has already mentioned, my Customers need to
> have ACPI on ARM servers for them to be successful in their business.
> I view my job as providing what my Customers need to be successful.
> So, here I am.  I want ACPI on ARMv8 for my Customers.

I want that too, even for platforms that might not ever run Windows.

-- ljk

> 
>> You snipped quite a lot of reasons why ACPI is inferior that were
>> below this line in email.
>>
>> 									Pavel
>>
>> (1) ignoring fact that it causes fragmentation between servers and phones.
>>
> 
> I see this very differently.  This is a "fact" only when viewed from
> the perspective of having two different technologies that can do very
> similar things.
> 
> In my opinion, the issue is that these are two very, very different
> markets; technologies are only relevant as the tools to be used to be
> successful in those markets.
> 
> Just on a surface level, phones are expected to be completely replaced
> every 18 months or less -- new hardware, new version of the OS, new
> everything. That's the driving force in the market.
> 
> A server does not change that quickly; it is probable that the hardware
> will change, but it is unlikely to change at that speed.  It can take
> 18 months just for some of the certification testing needed for new
> hardware or software.  Further, everything from the kernel on up is
> expected to be stable for a long time -- as long as 25 years, in some
> cases I have worked on.  "New" can be a bad word in this environment.
> 
> Best I can tell, I need different tool sets to do well in each of these
> environments -- one that allows me to move quickly for phones, and one
> that allows me to carefully control change for servers.  I personally
> don't see that as fragmentation, but as using the right tool for the
> job.  If I'm building a phone, I want the speed and flexibility of DT.
> If I'm building a server, I want the long term stability of ACPI.
> 
