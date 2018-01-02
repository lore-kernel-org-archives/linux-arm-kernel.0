From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jan 2018 10:23:00 +0100
Subject: [PATCH v2] ARM: dts: Add TVE/TVC and ILI9322 panel to DIR-685
In-Reply-To: <b929dd94-44e8-517a-7934-e0deb035faf5@lechnology.com>
References: <20171222085151.17635-1-linus.walleij@linaro.org>
 <b929dd94-44e8-517a-7934-e0deb035faf5@lechnology.com>
Message-ID: <CACRpkdbLCoN5Vak8LQ+aDaZNP_Bd8ttWzWtvAV5z612NHCqDOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 1, 2018 at 8:14 PM, David Lechner <david@lechnology.com> wrote:
> On 12/22/2017 02:51 AM, Linus Walleij wrote:

>> @@ -115,7 +156,16 @@
>>         soc {
>>                 flash at 30000000 {
>> -                       status = "okay";
>> +                       /*
>> +                        * Flash access is by default disabled, because it
>> +                        * collides with the Chip Enable signal for the
>> display
>> +                        * panel, that reuse the parallel flash Chip
>> Select 1
>> +                        * (CS1). Enabling flash makes graphics stop
>> working.
>> +                        *
>> +                        * We might be able to hack around this by letting
>> +                        * GPIO poke around in the flash controller
>> registers.
>> +                        */
>> +                       /* status = "okay"; */
>
>
> Isn't the default status = "okay"? So you would need to explicitly say
> status = "disabled".

This file includes gemini.dtsi where this node is defined, and there it
is set to status = "disabled", so we used to activate the dormant node
here with an explicit status = "okay".

Yours,
Linus Walleij
