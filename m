From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 27 Feb 2015 15:52:54 -0800
Subject: [PATCH 2/3] dtb: change binding name to match with newer firmware
 DT
In-Reply-To: <4061014.S4PDWltU3G@wuerfel>
References: <1425067710-14879-1-git-send-email-isubramanian@apm.com>
 <1425067710-14879-3-git-send-email-isubramanian@apm.com>
 <4061014.S4PDWltU3G@wuerfel>
Message-ID: <CAKh23Fm5HpNEfs40RTf_XtQ6ris5cCheAcY1WdLND04AwsvdSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 12:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 27 February 2015 12:08:29 Iyappan Subramanian wrote:
>> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> index f1ad9c2..a857794 100644
>> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
>> @@ -622,7 +622,7 @@
>>                 };
>>
>>                 sgenet0: ethernet at 1f210000 {
>> -                       compatible = "apm,xgene-enet";
>> +                       compatible = "apm,xgene1-sgenet";
>>                         status = "disabled";
>>                         reg = <0x0 0x1f210000 0x0 0xd100>,
>>                               <0x0 0x1f200000 0x0 0Xc300>,
>>
>
> This will break booting the new dtb on older kernels, right?

This will not break booting older kernels.  In fact, this will fix it,
by having the specific binding,
older kernel that does not have support for these interfaces, will not
call probe.

For example, 3.17 kernel that does not have support for SGMII based 1G
and XFI 10G interfaces
will not probe these interfaces when booted with newer dtb.

>
> You should normally list the most generic model in addition to the
> specific one.

If we list generic model ("xgene-enet") as well, probe will be called
for the interfaces that the kernel does not have support for,
which is what we are trying to fix.

>
>         Arnd
