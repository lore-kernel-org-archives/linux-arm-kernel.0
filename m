From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu, 20 Sep 2012 12:19:26 +0200
Subject: [PATCH v2 2/2] ARM: at91: add at91sam9_wdt driver to at91sam9260
In-Reply-To: <20120920100724.GF17667@game.jcrosoft.org>
References: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
 <1348055861-7857-3-git-send-email-fabio.porcedda@gmail.com>
 <20120920052928.GE17667@game.jcrosoft.org>
 <CAHkwnC9jqUmb+AGCnxV9QeSv=5JjS4+AWnutkm6TZPJJRcxGAA@mail.gmail.com>
 <20120920100724.GF17667@game.jcrosoft.org>
Message-ID: <CAHkwnC8csOuYMVkO2cfgmcVdfm5uYtZ82ibFC-RfMLL8-dynmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 12:07 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 09:52 Thu 20 Sep     , Fabio Porcedda wrote:
>> Hi Jean-Christophe,
>>
>> On Thu, Sep 20, 2012 at 7:29 AM, Jean-Christophe PLAGNIOL-VILLARD
>> <plagnioj@jcrosoft.com> wrote:
>> > On 13:57 Wed 19 Sep     , Fabio Porcedda wrote:
>> >> Tested on an at91sam9260 board (evk-pro3)
>> >>
>> >> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> >> ---
>> >>  arch/arm/boot/dts/at91sam9260.dtsi | 6 ++++++
>> >>  1 file changed, 6 insertions(+)
>> >>
>> >> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
>> >> index 66389c1..680b1c8 100644
>> >> --- a/arch/arm/boot/dts/at91sam9260.dtsi
>> >> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
>> >> @@ -233,6 +233,12 @@
>> >>                                       trigger-external;
>> >>                               };
>> >>                       };
>> >> +
>> >> +                     watchdog at fffffd40 {
>> > disable dy default
>>
>> All the others watchdog drivers in arch/arm/boot/dts/* are enabled by default.
>> IMHO the watchdog driver it's like the "rtstc" and "shdwc" driver,
>> they are safe to be enabled by default.
>> I'm missing something?
> no the other watchdog will not reset if not managed
>
> this one will
>
> so I'm not confortable by enabling it by default

Ok, i will send an updated patch.

Thanks for the review
-- 
Fabio Porcedda
