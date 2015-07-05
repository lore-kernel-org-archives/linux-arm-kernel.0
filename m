From: robherring2@gmail.com (Rob Herring)
Date: Sun, 5 Jul 2015 09:39:26 -0500
Subject: [PATCH v2 4/9] arm: twr-k70f120m: timer driver for Kinetis SoC
In-Reply-To: <2939807.q7WvOoYzDX@wuerfel>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-5-git-send-email-pawelo@king.net.pl>
 <2939807.q7WvOoYzDX@wuerfel>
Message-ID: <CAL_Jsq+r9fNWqD9O8Kz7Tn7oCaiJv7fSjEJ5QNcf+YLO146wPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 3:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 30 June 2015 14:27:25 Paul Osmialowski wrote:
>

>>  / {
>> +     aliases {
>> +             pit0 = &pit0;
>> +             pit1 = &pit1;
>> +             pit2 = &pit2;
>> +             pit3 = &pit3;
>> +     };
>> +
>>       soc {
>> +             pit at 40037000 {
>> +                     compatible = "fsl,kinetis-pit-timer";
>> +                     reg = <0x40037000 0x100>;
>> +                     clocks = <&mcg_pclk_gate 5 23>;
>> +                     #address-cells = <1>;
>> +                     #size-cells = <1>;
>> +                     ranges;
>> +
>> +                     pit0: timer at 40037100 {
>> +                             reg = <0x40037100 0x10>;
>> +                             interrupts = <68>;
>> +                             status = "disabled";
>> +                     };
>
> I don't think it's necessary to have both an alias
> and a label here. What do you use the alias for?

Yes, don't use aliases. If you really need a specific timer to be used
then there must be some feature it has or doesn't have (e.g. always
on, output compare pin, specific clock, etc.) Put those those
properties in DT if that is the case. See OMAP timers for a complex
example of this.

Rob
