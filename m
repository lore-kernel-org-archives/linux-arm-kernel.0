From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 31 Mar 2015 11:11:09 +0200
Subject: ARM, earlyconsole and io mapping
In-Reply-To: <5519DCDE.4010406@hurleysoftware.com> (Peter Hurley's message of
 "Mon, 30 Mar 2015 19:31:42 -0400")
References: <87iodivgfm.fsf@free.fr> <5519DCDE.4010406@hurleysoftware.com>
Message-ID: <874mp1v8eq.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Hurley <peter@hurleysoftware.com> writes:

> Hi Robert,
>
> On 03/30/2015 08:05 AM, Robert Jarzmik wrote:
>> Hi,
>> 
>> I was wondering how the earlyconsole was supposed to work in order to add
>> support to the pxa architecture. More specifically, I don't understand how the
>> memory mapping is supposed to be available at the early parameters parsing.
> Fixmap support has not been upstreamed yet, but if you're desperate, here's
> the latest patch version:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318372.html

Ah I'm not desperate, that would be nice to have tool on my automation
platform. I've gone the DEBUG_LL + JTAG/__log_buf memory dump so far.

And yet I remember viewing early concole patches a few monthes back, and I
wondered how the authors could make them work ... And as my memory didn't serve
me well, I couldn't remember your name.

> If you're using /chosen/stdout-path, earlycon gets turned off at dummy
> VT console load, so for right now, specify your earlycon and consoles on the
> command line.
Ah I'm using device-tree in only 1/3rd of the PXA tests :
 - 1/3rd for legacy platform_data tests
 - 1/3rd for device-tree pxa platforms
 - 1/3rd for multiplatform kernel

Anyway, I hope you'll have Russell's comments addressed, and that your patch
will make it upstream. Thanks for the information, it is exactly what I was
asking for.

Cheers.

-- 
Robert
