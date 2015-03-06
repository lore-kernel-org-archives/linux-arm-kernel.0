From: notasas@gmail.com (Grazvydas Ignotas)
Date: Sat, 7 Mar 2015 00:12:07 +0200
Subject: twl4030_charger: need changes to get probed?
In-Reply-To: <201503062257.58180@pali>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150305173350.50502b95@notabene.brown>
 <20150306212417.GA24169@amd> <201503062257.58180@pali>
Message-ID: <CANOLnONUtfF1UwgW3O5fkAX30UMznZXwbtPkqPFDLR4jFdNqow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 6, 2015 at 11:57 PM, Pali Roh?r <pali.rohar@gmail.com> wrote:
> On Friday 06 March 2015 22:24:17 Pavel Machek wrote:
>> Hi!
>>
>> According to n900 dts, twl4030-bci (aka charger) should be
>> included.
>>
>
> AFAIK it is not present on n900...

Right, it uses twl5030 variant without the charger, charging on n900
is provided by separate chip and for a good reason as twl's charger is
not that good. Forcing the driver to load just ends up with it
accessing non-existent registers over i2c.


Gra?vydas
