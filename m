From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Fri, 22 Jul 2016 11:10:46 +0200
Subject: [PATCH 14/18] ARM: mvebu: add support for the Armada 395 SoC
 family
In-Reply-To: <20160721221605.GA21883@rob-hp-laptop>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-16-git-send-email-jaz@semihalf.com>
 <20160721221605.GA21883@rob-hp-laptop>
Message-ID: <CAH76GKOidxFZ7R1pQZ2W9BRBCxEnLXNHQGrXbAUmouozBUj51Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

2016-07-22 0:16 GMT+02:00 Rob Herring <robh@kernel.org>:
> On Thu, Jul 21, 2016 at 02:44:11PM +0200, Grzegorz Jaszczyk wrote:
>> -compatible = "marvell,a398-db", "marvell,armada398", "marvell,armada390";
>> +compatible = "marvell,a398-db", "marvell,armada398", "marvell,armada395", "marvell,armada390";
>
> If 395 came after 398, then it should come first in the order. This
> implies that marvell,armada398 is a better match than marvell,armada395.
> Or perhaps you shouldn't have both?
>
> Rob

I am not sure if I get your point. The Armada-398 extends the
Armada-395 about 2 additional SATA ports (as you can see in commit
"[PATCH 15/18] ARM: mvebu: a398: update the dtsi about missing
interfaces"). In this example the a398-db board contains the Armada398
SoC, so it is a better match and goes first.

Quite the same is for existing armada-388-db.dts, in which compatible
looks like this:
compatible = "marvell,a385-db", "marvell,armada388",
"marvell,armada385", "marvell,armada380";

In above, Armada-388 also extends the Armada-385 and the order of the
compatible is similar to one from my example.

Thank you,
Grzegorz
