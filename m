From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 30 Mar 2015 14:11:48 +0200
Subject: ARM, earlyconsole and io mapping
In-Reply-To: <87iodivgfm.fsf@free.fr>
References: <87iodivgfm.fsf@free.fr>
Message-ID: <20150330141148.299f38a4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Robert Jarzmik,

On Mon, 30 Mar 2015 14:05:33 +0200, Robert Jarzmik wrote:

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

A very early mapping of the I/O space is done in head.S, way before you
get into C code:

  http://lxr.free-electrons.com/source/arch/arm/kernel/head.S#L277

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
