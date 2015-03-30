From: peter@hurleysoftware.com (Peter Hurley)
Date: Mon, 30 Mar 2015 19:31:42 -0400
Subject: ARM, earlyconsole and io mapping
In-Reply-To: <87iodivgfm.fsf@free.fr>
References: <87iodivgfm.fsf@free.fr>
Message-ID: <5519DCDE.4010406@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 03/30/2015 08:05 AM, Robert Jarzmik wrote:
> Hi,
> 
> I was wondering how the earlyconsole was supposed to work in order to add
> support to the pxa architecture. More specifically, I don't understand how the
> memory mapping is supposed to be available at the early parameters parsing.
> 
> The thing I don't understand is that :
>  - in kernel initialization, parse_early_param() is called before
>    machine_desc->map_io()
>  - as a consequence, the architecture didn't add the vm early mapping for serial
>    peripheral (which is added in pxa_map_io())
>  - as a consequence, earlycon_map() will fail to map the serial MMIO
>    (as in stack showed in [1])
> 
> Therefore, are there non-DT earlycon users on the list, and could they tell me
> what way they get earlycon support in their arm boards please ?

Fixmap support has not been upstreamed yet, but if you're desperate, here's
the latest patch version:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318372.html


If you're using /chosen/stdout-path, earlycon gets turned off at dummy
VT console load, so for right now, specify your earlycon and consoles on the
command line.

Regards,
Peter Hurley
