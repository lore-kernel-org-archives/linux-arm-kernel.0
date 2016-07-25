From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jul 2016 10:12:43 -0500
Subject: [PATCH 14/18] ARM: mvebu: add support for the Armada 395 SoC
 family
In-Reply-To: <20160725155050.3aee974e@free-electrons.com>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-16-git-send-email-jaz@semihalf.com>
 <20160721221605.GA21883@rob-hp-laptop>
 <CAH76GKOidxFZ7R1pQZ2W9BRBCxEnLXNHQGrXbAUmouozBUj51Q@mail.gmail.com>
 <CAL_JsqJeObuS8OWeErRA5MX-SrMtu_254A-LtP9-A=xdPO7p1Q@mail.gmail.com>
 <20160725155050.3aee974e@free-electrons.com>
Message-ID: <CAL_JsqL=bkzhjOTcOCeGNvKsAfYg0D=CypZs4sCsQ01pnbitoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2016 at 8:50 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Mon, 25 Jul 2016 08:47:23 -0500, Rob Herring wrote:
>
>> > I am not sure if I get your point. The Armada-398 extends the
>> > Armada-395 about 2 additional SATA ports (as you can see in commit
>> > "[PATCH 15/18] ARM: mvebu: a398: update the dtsi about missing
>> > interfaces"). In this example the a398-db board contains the Armada398
>> > SoC, so it is a better match and goes first.
>>
>> But your patch title is adding 395 support, but you are adding the
>> string to a 398 based board. It would make sense to have 395 here if
>> the OS already had support for 395 and you want to support the 398
>> without updating the OS. That doesn't seem to apply here.
>
> I think the argument of Grzegorz is that the 398 is functionally a
> strict superset of the 395, so that anything that applies to the 395
> will also apply to 398.

Yes, I get that, but that is only meaningful if you want to run an OS
that is only aware of 395 on a 398 SoC/board (though I'd guess the 390
compat is enough for that). Otherwise, that property is not really
meaningful as the additional nodes are enough to handle what is the
superset.

I would agree both are fine if both chips are in fact the same die,
just fused or packaged differently. I've seen a lot of chips that are
supposed to be sub/supersets of each other, but have different errata
lists because they are different die.

Rob
