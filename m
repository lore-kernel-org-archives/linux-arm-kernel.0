From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 27 Sep 2017 00:33:59 +0200
Subject: [PATCH 01/12] mmc: dt-bindings: update Mediatek MMC bindings
In-Reply-To: <1505355021.8308.4.camel@mhfsdcap03>
References: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
 <1505207272-16983-2-git-send-email-chaotian.jing@mediatek.com>
 <20170913141026.43oh4n4foipmahsk@rob-hp-laptop>
 <1505355021.8308.4.camel@mhfsdcap03>
Message-ID: <CAPDyKFrUe-0hEsxVRQSZvujcXY8WrR6m-0DMW=VwDDLvz7Lexw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 September 2017 at 04:10, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> On Wed, 2017-09-13 at 09:10 -0500, Rob Herring wrote:
>> On Tue, Sep 12, 2017 at 05:07:41PM +0800, Chaotian Jing wrote:
>> > Change the comptiable for support of multi-platform
>> > Add description for reg
>> > Add description for source_cg
>> > Add description for mediatek,latch-ck
>>
>> This is at least the 3rd patch with exactly the same vague subject.
>> Please make the subject somewhat unique.
>>
> Thx, will change the subject at next version
>> >
>> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>> > ---
>> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 13 ++++++++++---
>> >  1 file changed, 10 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>> > index 4182ea3..405cd06 100644
>> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>> > @@ -7,10 +7,15 @@ This file documents differences between the core properties in mmc.txt
>> >  and the properties used by the msdc driver.
>> >
>> >  Required properties:
>> > -- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc"
>> > +- compatible: value should be either of the following.
>> > +   "mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
>> > +   "mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
>> > +   "mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
>> > +   "mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
>> > +- reg: physical base address of the controller and length
>> >  - interrupts: Should contain MSDC interrupt number
>> > -- clocks: MSDC source clock, HCLK
>> > -- clock-names: "source", "hclk"
>> > +- clocks: MSDC source clock, HCLK, source_cg
>> > +- clock-names: "source", "hclk", "source_cg"
>>
>> All chips support source_cg? That's not backwards compatible for
>> existing compatible strings if the driver requires it.
> Not all chips support source_cg, for chips which do not support
> source_cg, no need source_cg here, and the driver will parse it
> to know if current chip support it.

In such case you must not add add a required binding for it. I think
that is what Rob is trying to point out for you.

[...]

Kind regards
Uffe
