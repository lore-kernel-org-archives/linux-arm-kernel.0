From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2016 15:36:40 +0200
Subject: [PATCH 4/4 v2] ARM: dts: add SMSC ethernet on the APQ8060
 Dragonboard
In-Reply-To: <201608291521.42823.arnd@arndb.de>
References: <1472028758-29272-1-git-send-email-linus.walleij@linaro.org>
 <1472028758-29272-5-git-send-email-linus.walleij@linaro.org>
 <201608291521.42823.arnd@arndb.de>
Message-ID: <CACRpkdZQusPDYp6t2Bq8SJjYoHnELn_pjygFqeG8PKQ3L1YyFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 3:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 24 August 2016, Linus Walleij wrote:
>> +                       /*
>> +                        * An on-board SMSC LAN9221 chip for "debug ethernet",
>> +                        * which is actually just an ordinary ethernet on the
>> +                        * EBI2. This has a 25MHz chrystal next to it, so no
>> +                        * clocking is needed.
>> +                        */
>> +                       ethernet-ebi2 at 2,1b800000 {
>> +                               compatible = "smsc,lan9221", "smsc,lan9115";
>> +                               reg = <2 0x0 0x100>;
>> +                               /*
>
> The unit address does not match the register property here.

So the convention is: ethernet-ebi2 at 2,0 I take it, OK fixing!
(Also in the bindings.)

Yours,
Linus Walleij
