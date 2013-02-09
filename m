From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Feb 2013 20:15:56 -0700
Subject: [PATCH] MAINTAINERS: add keyword "tegra" to Tegra section
In-Reply-To: <1360371906.13487.9.camel@joe-AO722>
References: <1360353891-24210-1-git-send-email-swarren@wwwdotorg.org>
 <1360370419.13487.8.camel@joe-AO722> <51159C96.5080505@wwwdotorg.org>
 <1360371906.13487.9.camel@joe-AO722>
Message-ID: <5115BF6C.6050509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 06:05 PM, Joe Perches wrote:
> On Fri, 2013-02-08 at 17:47 -0700, Stephen Warren wrote:
>> On 02/08/2013 05:40 PM, Joe Perches wrote:
>>> On Fri, 2013-02-08 at 13:04 -0700, Stephen Warren wrote:
>>>> (?<!in)tegra
>>>
>>> This doesn't work well.   It matches too many
>>> words like integral.
>>
>> Hmmm. That's exactly what the (?<!in) negative look-behind assertion is
>> attempting to avoid. It works fine here. Is there some dependency on
>> Perl version or something? My Perl version is v5.14.2.
> 
> Integral matches
> 
> I don't see any issue with using a leading \b

Oh right, it's a capitalization issue; I only tested with "integral" not
"Integral".

The problem with \btegra is that it wouldn't match _tegra, which would
be useful. Perhaps a custom almost-equivalent (?i)[^a-z]tegra would work?
