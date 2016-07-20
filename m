From: olivier.schonken@gmail.com (Olivier Schonken)
Date: Wed, 20 Jul 2016 10:17:09 +0200
Subject: [PATCH v2 2/2] ARM: dts: at91: sama5d2: add ETM and ETB nodes
In-Reply-To: <CANLsYkw830w5f3R55QMaNbT8hn+PE9CA9bm5MwiT0RhYVXqq=w@mail.gmail.com>
References: <1467705950-29482-1-git-send-email-olivier.schonken@gmail.com>
 <1467705950-29482-2-git-send-email-olivier.schonken@gmail.com>
 <CANLsYkw830w5f3R55QMaNbT8hn+PE9CA9bm5MwiT0RhYVXqq=w@mail.gmail.com>
Message-ID: <CALdGskJV-OO7hPVom4MDaUuc2nyUL=Chx5p+MLhzfxPf5sffjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All

Just wondering if there are still some issues regarding the sama5d2
ETM and ETB nodes patch that I have to change/update.
If I should resend at a better time for it to not get lost in the
noise just let me know.

I see that I accidentily left Boris out in the initial resend of the
patch.  My apologies.  Will forward the initial send to him as well.

Regards

Olivier Schonken

On 5 July 2016 at 18:16, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> On 5 July 2016 at 02:05, Olivier Schonken <olivier.schonken@gmail.com> wrote:
>> Add node to support SAMA5D2 Embedded Trace Macrocell and Embedded
>> Trace Buffer.
>>
>> This patch depends on coresight-etm3x: Add ARM ETM-A5 peripheral ID
>> for proper coresight functionality.
>> It also depends on clocksource: timer-atmel-pit: enable mck to not
>> stall SAMA5D2 on bootup.
>>
>> Signed-off-by: Olivier Schonken <olivier.schonken@gmail.com>
>> ---
>>  arch/arm/boot/dts/sama5d2.dtsi | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
>> index 5d63206..bde24ab 100644
>> --- a/arch/arm/boot/dts/sama5d2.dtsi
>> +++ b/arch/arm/boot/dts/sama5d2.dtsi
>> @@ -77,6 +77,35 @@
>>                 interrupts = <2 IRQ_TYPE_LEVEL_HIGH 0>;
>>         };
>>
>> +       etb {
>> +               compatible = "arm,coresight-etb10", "arm,primecell";
>> +               reg = <0x740000 0x1000>;
>> +
>> +               clocks = <&mck>;
>> +               clock-names = "apb_pclk";
>> +
>> +               port {
>> +                       etb_in: endpoint {
>> +                               slave-mode;
>> +                               remote-endpoint = <&etm_out>;
>> +                       };
>> +               };
>> +       };
>> +
>> +       etm {
>> +               compatible = "arm,coresight-etm3x", "arm,primecell";
>> +               reg = <0x73C000 0x1000>;
>> +
>> +               clocks = <&mck>;
>> +               clock-names = "apb_pclk";
>> +
>> +               port {
>> +                       etm_out: endpoint {
>> +                               remote-endpoint = <&etb_in>;
>> +                       };
>> +               };
>> +       };
>> +
>>         memory {
>>                 reg = <0x20000000 0x20000000>;
>>         };
>> --
>> 1.9.1
>>
>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
