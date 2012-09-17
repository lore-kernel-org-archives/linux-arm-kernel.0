From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 17 Sep 2012 08:36:28 +0200
Subject: [PATCH v4 03/10] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <alpine.LFD.2.02.1209162137270.28681@xanadu.home>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120916074652.GM28177@lunn.ch> <20120916124015.GI5469@titan.lakedaemon.net>
 <alpine.LFD.2.02.1209162137270.28681@xanadu.home>
Message-ID: <5056C4EC.1030305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2012 03:55 AM, Nicolas Pitre wrote:
> On Sun, 16 Sep 2012, Jason Cooper wrote:
>> On Sun, Sep 16, 2012 at 09:46:52AM +0200, Andrew Lunn wrote:
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt
>>>> @@ -0,0 +1,279 @@
>>>> +* Marvell Kirkwood SoC pinctrl driver for mpp
>>>> +
>>>> +Please refer to marvell,mvebu-pinctrl.txt in this directory for common binding
>>>> +part and usage.
>>>> +
>>>> +Required properties:
>>>> +- compatible: "marvell,88f6180-pinctrl",
>>>> +              "marvell,88f6190-pinctrl", "marvell,88f6192-pinctrl",
>>>> +              "marvell,88f6281-pinctrl", "marvell,88f6282-pinctrl"
>>>> +
>>>> +This driver supports all kirkwood variants, i.e. 88f6180, 88f619x, and 88f628
 >>> ...
>>> If i wanted to mass convert all existing kirkwood DT boards over to
>>> use pinctrl, im stuck at the very first step. I've no idea what chip
>>> they use, it was not relevant before.
>>
>> Let's try to do the DT correctly, and create a migration path for
>> kirkwood to work first, then migrate to using the DT fully.
>
> Beware beware.
>
> The DT should of course describe the hardware as accurately as possible.
> That doesn't necessarily mean it should describe the hardware as
> _extensively_ as possible.
>
> And that doesn't mean that all the information found in the DT has to be
> consumed by the kernel either.
>
> Any information that can be *probed* at run time has no benefit being
> stuffed in a DT.  That's true whether it is Linux or another operating
> system.  The more that can be probed at run time the better.

I had a closer look at how kirkwood probes its id. I mentionend kirkwood_id()
earlier but in fact it is kirkwood_pcie_id(). I assume pcie registers are shut
down with pcie clk gated? That would require to have pcie running at least at
boot-time on all boards.

While it is still possible to grab the id and power down pcie later, I still
think that using five different compatible strings is better here. Of course,
there is some effort to obtain the kirkwood SoC variant for all boards.

Sebastian
