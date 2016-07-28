From: robh@kernel.org (Rob Herring)
Date: Thu, 28 Jul 2016 10:59:38 -0500
Subject: [PATCH 14/18] ARM: mvebu: add support for the Armada 395 SoC
 family
In-Reply-To: <87y44mj9h8.fsf@free-electrons.com>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-16-git-send-email-jaz@semihalf.com>
 <20160721221605.GA21883@rob-hp-laptop>
 <CAH76GKOidxFZ7R1pQZ2W9BRBCxEnLXNHQGrXbAUmouozBUj51Q@mail.gmail.com>
 <CAL_JsqJeObuS8OWeErRA5MX-SrMtu_254A-LtP9-A=xdPO7p1Q@mail.gmail.com>
 <20160725155050.3aee974e@free-electrons.com>
 <CAL_JsqL=bkzhjOTcOCeGNvKsAfYg0D=CypZs4sCsQ01pnbitoQ@mail.gmail.com>
 <20160725202209.5fae4d98@free-electrons.com>
 <87y44mj9h8.fsf@free-electrons.com>
Message-ID: <CAL_Jsq+Or4=Oa5+OMw5pZh6CBgHktiTL89UcZcw6pJ1VBWB8cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2016 at 6:19 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Rob,
>
>  On lun., juil. 25 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
>
>> Hello,
>>
>> On Mon, 25 Jul 2016 10:12:43 -0500, Rob Herring wrote:
>>
>>> Yes, I get that, but that is only meaningful if you want to run an OS
>>> that is only aware of 395 on a 398 SoC/board (though I'd guess the 390
>>> compat is enough for that). Otherwise, that property is not really
>>> meaningful as the additional nodes are enough to handle what is the
>>> superset.
>>>
>>> I would agree both are fine if both chips are in fact the same die,
>>> just fused or packaged differently. I've seen a lot of chips that are
>>> supposed to be sub/supersets of each other, but have different errata
>>> lists because they are different die.
>>
>> Unfortunately HW vendors are rarely willing to publicly indicate whether
>> the different chips in their families are actually the same die fused
>> differently, or really different dies.

Then it is safest to assume they are different.

> So do you want that we keep both "marvell,armada398" and
> "marvell,armada395" or do you xant we use only "marvell,armada398" ?

For the 398 based boards, I think it should only have
"marvell,armada398" and don't add "marvell,armada395".

Rob
