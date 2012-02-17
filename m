From: nm@ti.com (Menon, Nishanth)
Date: Fri, 17 Feb 2012 09:22:54 -0600
Subject: [PATCHv9 3/5] arm: omap3: add common twl configurations for vdd1
 and vdd2
In-Reply-To: <1329476814.4102.433.camel@sokoban>
References: <1329388073-17879-1-git-send-email-t-kristo@ti.com>
 <1329388073-17879-4-git-send-email-t-kristo@ti.com>
 <CAOMWX4d8C4pjYSr+i3qmqfJHDsHQdtRkvfbGR29U7hXf0SkVZg@mail.gmail.com>
 <1329476814.4102.433.camel@sokoban>
Message-ID: <CAOMWX4cmwFKsQ9SV-9c=tfCEqdQ9N2TcJUJ+Sh=syBgOSPz1gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regards,
Nishanth Menon



On Fri, Feb 17, 2012 at 05:06, Tero Kristo <t-kristo@ti.com> wrote:
> On Thu, 2012-02-16 at 12:23 -0600, Menon, Nishanth wrote:
>> On Thu, Feb 16, 2012 at 04:27, Tero Kristo <t-kristo@ti.com> wrote:
>> > VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
>> > to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
>> > are needed by DVFS.
>> >
>> > Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data manual.
>>
>> Please provide documentation version referenced, else we will loose
>> track of details at a later point of time.
>
> How should this be marked down? There are too many naming conventions
> for the TI docs, and I couldn't find any example from kernel commit logs
> for this. Personally I was using twl5030 es1.2 DM rev E / twl4030 es3.1
> DM rev L. Or should the literature code be used? Or is there also some
> numerical version info available somewhere?
Literature code is the best one. Adding, along with it, a human
readable "TWL4030 ES3.1 DM rev L"
is even better :)

>> Also should we rename VDD1 with vdd_mpu_iva and VDD2 as vdd_core to be readable?
>
> This can be changed if needed, it is just a name.
> regulator/twl-regulator.c is using vdd1 / vdd2 though, and also
> pmic_data struct uses these. All the other regulators use Vxx type
> naming also. These are the names I see on my board through
> sys/class/regulator:
>
> dummy
> VDD1
> VDD2
> VMMC1
> VDAC
> VDVI
> VSIM

no strong opinions on this - thinking from OMAP perspective, I read
vdd_mpu,core,iva. from TWL perspective,
4030/5030 - VDD1,2
6030: VCORE1,2,3
6032: SMPS1...5
so I guess it is fine as long as it is in context.
