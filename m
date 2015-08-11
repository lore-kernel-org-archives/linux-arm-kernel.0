From: robdclark@gmail.com (Rob Clark)
Date: Mon, 10 Aug 2015 20:40:52 -0400
Subject: [PATCH v1 7/7] ARM: dts: ifc6410: add inforce LVDS panel support
In-Reply-To: <20150810232552.GB13472@usrtlx11787.corpusers.net>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088076-17606-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150810232552.GB13472@usrtlx11787.corpusers.net>
Message-ID: <CAF6AEGumORyT=NimGHFT8jyN4fQ1=xeo31tnvm5X3VndM-J5LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 7:25 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> On Tue 28 Jul 05:54 PDT 2015, Srinivas Kandagatla wrote:
>
>> This patch adds LVDS panel for IFC6410.
>>
>
> My ifc6410 doesn't have a LVDS display, so I don't think these nodes
> belong in this dts file.

fwiw, my hope was that we could implement a panel-picker for lvds+ddc,
in a similar way to handling devices that could have multiple
different dsi panels, to make this a bit more automagically
plug-and-play.. srini has done some experiments with probing panel's
edid, so we just need to figure out if vendor+device-id in edid is
reliable enough to have a global table mapping them back to panel
compat strings or whether that table needs to go in dt..

BR,
-R

> I was thinking we could have a variant including this dts file adding
> the panel, but I assume that you can mount other panels than the auo
> panel defined below?
>
>
> Either way, I think we should keep this file to define the stuff that's
> on the IFC6410 itself and then figure out how to aid people in adding
> the rest of their additions...
>
> Regards,
> Bjorn
