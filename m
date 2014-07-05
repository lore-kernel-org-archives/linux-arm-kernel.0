From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 5 Jul 2014 18:06:29 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140705164348.GM14896@sirena.org.uk>
References: <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com> <20140702163923.GJ410@sirena.org.uk>
 <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703174318.GE28175@arm.com>
 <20140704132250.A2447C40ADD@trevor.secretlab.ca>
 <20140705111406.GA23692@arm.com> <20140705164348.GM14896@sirena.org.uk>
Message-ID: <FFC4CCB1-115D-4A20-A79D-78200D02D90F@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 Jul 2014, at 17:43, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Jul 05, 2014 at 12:14:07PM +0100, Catalin Marinas wrote:
> 
>> The timeline I propose would be:
>> 
>> 1. Architecture feature deprecation (still present, no way to disable)
>>   - In Linux we need to find ways and push for alternatives to be
>>     adopted by user space (like we did with kuser helpers)
> 
> Is it worth adding a non-default option to either disable and emulate or
> just completely disable during this phase rather than at step 2 (perhaps
> with a sysctl)?  That would help people who want to test that what they
> are doing is going to work going forwards.  The work is going to have to
> happen anyway.

The problem is that when the feature is deprecated, we may not always
get the option to disable it (it?s more of an advance warning to think
about it, that?s why I added emulation at step 2). For example SWP has
been deprecated in ARMv6 but no way to disable it until ARMv7 MP. If we
get the option (and we should probably recommend this to the
architects), I agree, you can start the emulation work at step 1 but
defaulting to native deprecated feature rather than emulation.

Catalin
