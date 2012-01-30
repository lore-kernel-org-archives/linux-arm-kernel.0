From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 30 Jan 2012 22:49:57 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxf+okps60OxQnPkqHck8pWHrkPnT6boo603pC2XEbFYoRQ@mail.gmail.com>
References: <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
 <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
 <20120127132826.GD2347@mudshark.cambridge.arm.com>
 <CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
 <CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
 <20120127155454.GH2347@mudshark.cambridge.arm.com>
 <CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
 <20120127165941.GK2347@mudshark.cambridge.arm.com>
 <CAMsRxf+iv06zOCMzhYONeLaf6RvOLp38T53mR--8ESHvCXMeFQ@mail.gmail.com>
 <20120127171009.GL2347@mudshark.cambridge.arm.com>
 <CAMsRxfJufRMrcfGZp53ALOdEFLk+YDMvQMrHw-jR9tQ8ThE+-Q@mail.gmail.com>
 <CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
 <CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
 <CAMsRxfJq1-tSQH4bv0BeNWXV9aysi9AUvywkh3e9SaamMDfZ0Q@mail.gmail.com>
 <CAMsRxf+okps60OxQnPkqHck8pWHrkPnT6boo603pC2XEbFYoRQ@mail.gmail.com>
Message-ID: <CACVXFVMDXO3DDj0mGh=+uDYfCoS_Ck1STVK0=UXjiAbtJTa=hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 9:43 PM, stephane eranian
<eranian@googlemail.com> wrote:
> Same results for me with 3.3.0-rc1 + 5 patches.

In fact, I think the only effect of the patch is to enable pmu
interrupt handling,
which may cause so much difference?

Also maybe you should put 'noploop' to run on CPU1 and you may observe
a more accurate result of 'top'.

On ARM, almost handling of all IRQs from gic is run on CPU0 at default,
which may cause your issue.

>
>
> top - 14:42:34 up 8 min, ?1 user, ?load average: 0.70, 0.29, 0.15
> Tasks: ?75 total, ? 2 running, ?73 sleeping, ? 0 stopped, ? 0 zombie
> Cpu(s): 32.9%us, ?1.3%sy, ?0.0%ni, 65.8%id, ?0.0%wa, ?0.0%hi, ?0.0%si, ?0.0%st
> Mem: ? ?940232k total, ? 118520k used, ? 821712k free, ? ? 8080k buffers
> Swap: ? 524240k total, ? ? ? ?0k used, ? 524240k free, ? ?79432k cached
>
> ? PID USER ? ? ?PR ?NI ?VIRT ?RES ?SHR S %CPU %MEM ? ?TIME+ ?COMMAND
> ?3868 eranian ? 20 ? 0 ? 644 ?160 ?128 R ? 99 ?0.0 ? 0:53.34 noploop
> ?3870 eranian ? 20 ? 0 ?2284 1060 ?804 R ? ?3 ?0.1 ? 0:00.63 top
> ? ? 1 root ? ? ?20 ? 0 ?2564 1532 ?952 S ? ?0 ?0.2 ? 0:01.26 init
>
> I am connecting to the board via ssh.
> But the results don't look correct to me.

thanks,
--
Ming Lei
