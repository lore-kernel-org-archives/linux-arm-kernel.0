From: al.stone@linaro.org (Al Stone)
Date: Thu, 15 Jan 2015 10:22:47 -0700
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <2277974.2klgILPa2Q@wuerfel>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6tjiE6u8i-1PHYzX2cOhxJkYN3cV9mqhCHRSMRdOQRfzg@mail.gmail.com>
 <54B7E21E.2000901@redhat.com> <2277974.2klgILPa2Q@wuerfel>
Message-ID: <54B7F767.6060808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2015 09:52 AM, Arnd Bergmann wrote:
> On Thursday 15 January 2015 10:51:58 Jon Masters wrote:
>> On 01/15/2015 09:10 AM, Grant Likely wrote:
>>> On Tue, Jan 6, 2015 at 1:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> For drivers merged upstream, I would insist that every driver merged
>>>> for an ARM64 platform has a documented DT binding that is used in the
>>>> driver.
>>>
>>> That's a dumb rule. It will result in untested DT code paths being
>>> thrown into drivers just too meet the rules rather than on whether or
>>> not they will actually be used. It's fine to allow driver authors to
>>> only implement the ACPI code path if that is what they are working
>>> with. We can *always* add a DT path to the driver when it is needed.
>>
>> It gets worse. There *will* be large numbers of ACPI only ARM servers
>> landing over the coming year. Not only would DT code be untested, but
>> insisting on keeping e.g. a DSDT and DT in sync is never going to work
>> anyway. Already we have early stage servers that contain a DT used for
>> bringup that is subsequently not being updated as often as the ACPI
>> tables (those systems are now booting exclusively in labs with ACPI).
>> Eventually, I am going to push for the DT data to be removed from these
>> systems rather than have out of date unmaintained DT data in firmware.
> 
> We will of course be able to relax the rule once ACPI has stabilized on
> ARM64. At the moment, we haven't even agreed on how to represent basic
> devices, so things are in flux and there is no way for a BIOS writer
> to ship an image that we will guarantee to support in the long run.
> 
> At some point after we are reasonably sure we are able to keep supporting
> all existing systems that are working with that kernel, we can take
> support for new systems without having DT by default, and also support
> booting those without acpi=force, which is related to this question.
> 
> 	Arnd
> 

Can I restate the position as I hear it, then?  I want to make sure
I'm understanding what's being said.

What I'm reading seems to say: if an ARMv8 vendor wants Linux support
in the upstream kernel, regardless of whether or not it is a mobile or
server product, they must submit DT-based patches until such time as
ACPI on arm64 is deemed "mature."  Do I have that correct?

That implies to me that if I want to build an ACPI-only product, there
is no way to predict when or if I can get Linux support.  And, that if
I do want Linux support, and need ACPI for my end-users, I have to
maintain both sets of firmware for some unknown time into the future.
Is that what was meant?

I'm not really trying to judge the position right this second, but I
am trying to make sure I understand it.  English is not really the most
precise of languages and I would prefer not to misinterpret.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
