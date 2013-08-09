From: olof@lixom.net (Olof Johansson)
Date: Fri, 9 Aug 2013 15:37:24 -0700
Subject: [PATCH 2/2] power: arm64: Add DTS entry for APM X-Gene reboot
 driver.
In-Reply-To: <20130809213116.GE12638@lizard.sbx05730.santaca.wayport.net>
References: <1372797539-13111-1-git-send-email-lho@apm.com>
 <1372797539-13111-2-git-send-email-lho@apm.com>
 <1372797539-13111-3-git-send-email-lho@apm.com>
 <20130809213116.GE12638@lizard.sbx05730.santaca.wayport.net>
Message-ID: <CAOesGMj-chSDsA7YT5GFAyoxPw43LOjbmnQUqo14nxJV_88GcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 9, 2013 at 2:31 PM, Anton Vorontsov <anton@enomsg.org> wrote:
> On Tue, Jul 02, 2013 at 02:38:59PM -0600, Loc Ho wrote:
>> power: arm64: Add DTS entry for APM X-Gene reboot driver.
>>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
>> ---
>
> I've applied patch 1/2 to battery-2.6.git tree. I need an ack from ARM
> maintainers to grab this together with the first one.
>
>>  arch/arm64/boot/dts/apm-storm.dtsi |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
>> index d37d736..e686919 100644
>> --- a/arch/arm64/boot/dts/apm-storm.dtsi
>> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
>> @@ -178,6 +178,12 @@
>>                       };
>>               };
>>
>> +                reboot at 0x17000014 {
>> +                        compatible = "apm,xgene-reboot";
>> +                        reg = <0x0 0x17000014 0x0 0x100>;
>> +                        mask = <0x1>;
>> +                };
>
> There should be tabs instead of whitespaces.

Binding is undocumented, as far as I can tell. Please add
documentation of this under Documentation/devicetree/bindings.

In particular, the 'mask' property is nonstandard and it needs to be
documented what part of the reboot controller hardware it is
describing.



-Olof
