From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 05 Aug 2013 11:08:27 +0100
Subject: [ARM ATTEND] Interested in R/M-class (!MMU), automated testing
In-Reply-To: <CAOesGMhDQE8S=L-h+5u3Q_h8Vm=vFs4swfR5Za2MVut7ai-yRQ@mail.gmail.com>
References: <51FBF93D.8040707@arm.com> <20130804122527.GV3880@pengutronix.de>
 <CAOesGMgnYLXRWRtKckofNpsxmRgT0cXL=JcAMirXibe92+AWOQ@mail.gmail.com>
 <CAOesGMhDQE8S=L-h+5u3Q_h8Vm=vFs4swfR5Za2MVut7ai-yRQ@mail.gmail.com>
Message-ID: <51FF799B.1000007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Robert

(+Paul Walmsley on CC as I mention his recent email below)
On 05/08/13 07:49, Olof Johansson wrote:
> [+ksummit-discuss which had fallen off]
> 
> On Sun, Aug 4, 2013 at 11:49 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Sun, Aug 4, 2013 at 5:25 AM, Robert Schwebel
>> <r.schwebel@pengutronix.de> wrote:
>>
>>>> - Ways to do more automated testing of ARM kernels, including hearing
>>>>    from other people what they use to build/boot/test/benchmark their
>>>>    code (perhaps even get a discussion going about using the diverse
>>>>    range of hardware people have around put to use as test-machines).
>>>
>>> That's pretty interesting; we have a test farm at PTX, but it mainly
>>> does nightly build + boot tests on mainline, for systems we care of.
>>
>> I have a small (but growing) farm of boards here that I do some (so
>> far) limited boot testing, but I do it a few times a day on mainline,
>> and nightly on linux-next and arm-soc for-next branches. I also do it
>> for -stable but right now only for published releases since I so far
>> only handle pulling whole git branches.
>>
>> I also build every defconfig on arm at the same cadence. Everything's
>> handled by a couple of scripts that emails me the results (as compared
>> to building a status webpage that I have to go check). So essentially
>> every morning I have an email with the fresh -next breakage waiting
>> for me to look at.
>>
>> The hardware comes from various sources; some I've bought myself,
>> other I've been sent by kind vendors. All of them are "modern" though,
>> i.e. v7-class hardware with decent amount of memory, etc. I netboot
>> everything with local rootfs at the moment.
>>
>>
>> I honestly don't know if there's much point in doing complex
>> centralized testing/reporting. I've found that I never go look for the
>> results. I don't regularly check Russell's autobuilder status, for

I broadly agree with you here - I find I tend to go and look there
when things are broken ("when did this first break?"), but honestly
wasn't aware of it until very recently and don't poll it.

I think that some level of centralised regression testing on
performance might be nice - if there was notification when things
jumped in a way that bucked the trend, for example, it might be good
to know about. Do your scripts monitor that sort of thing?

The other reason I mention sharing (which I guess implies something
a little centralised) is for the case where the code you are working
on has implications for a core you don't have - I'm not sure there
are many people with 11MPCores around, for example!

(However, I don't think anything that leads people to abdicate their
personal responsibility for testing patches before they go out the door
is a good idea!)

>> example. Nor the kisskb -next build status. But having my own scripts
>> email me has been useful. I do hope that most ARM subplatform
>> maintainers have some semi-automated setup for frequent testing as
>> well, but I know that reality is that far from all do.
>>
>> It could make sense to show what some of us use to give others
>> examples of what might work for them. There's a thousand ways to build
>> these kind of things, some elaborate and others quite simple. I've
>> definitely started at the simple end myself. :)
>>

I think this is more the sort of thing I was hoping to discuss.

I know Paul Walmsley has some pretty functional scripts that he's recently
offered to share part of (assuming he gets time to tidy them up):

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/187916.html

So that seems to be at least three separate approaches. Further, I took a
look recently at the ktest.pl script, which looked handy but not so
targetted at the ARM world, where you care about testing the same thing on
a wide array of platforms, might want an NFS root file-system, etc.

Here we tend to have a lot of hardware on our desks, and we test a lot
but mainly on an ad-hoc basis/where we see changes will intersect
with any specific board or core's quirks. Hearing how other people handle
automation would be great :)

Jonny
