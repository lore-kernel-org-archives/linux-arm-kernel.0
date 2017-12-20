From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:52:36 +1030
Subject: [PATCH v2 18/19] ARM: dts: aspeed-romulus: Update Romulus system
In-Reply-To: <b8e80861-88c4-da87-a201-ca2eefaa5a94@kaod.org>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-19-joel@jms.id.au>
 <b8e80861-88c4-da87-a201-ca2eefaa5a94@kaod.org>
Message-ID: <CACPK8Xdb59ofAnpGt6Uoe9AubTirzvU1=R-4k2y0mfjz09YAjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 8:02 PM, C?dric Le Goater <clg@kaod.org> wrote:
>> +};
>> +
>> +&fmc {
>> +     status = "okay";
>> +
>> +     flash at 0 {
>> +             status = "okay";
>> +             label = "pnor";
>> +             m25p,fast-read;
>> +#include "openbmc-flash-layout.dtsi"
>> +     };
>> +};
>> +
>> +&spi1 {
>> +     status = "okay";
>> +
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_spi1_default>;
>> +
>> +     flash at 0 {
>> +             status = "okay";
>> +             label = "pnor";
>> +             m25p,fast-read;
>>       };
>>  };
>
>
> hmm, the fmc and spi1 bindings were already added in commit 1142aea9ff9d.
>
>
>> @@ -38,6 +101,7 @@
>>               status = "okay";
>>               m25p,fast-read;
>>               label = "bmc";
>> +#include "openbmc-flash-layout.dtsi"
>
>
> This looks like an extra "fmc" node ?

You're right. It still built and booted too. Good catch.

Cheers,

Joel
