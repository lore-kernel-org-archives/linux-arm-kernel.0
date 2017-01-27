From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 27 Jan 2017 16:36:36 +0100
Subject: [PATCH v5 05/12] dt: bindings: Add bindings for Marvell Xenon SD
 Host Controller
In-Reply-To: <87fuk4yg1i.fsf@free-electrons.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <89c95d0084da6ad7132caa54ca66eb619d8a5090.1484154449.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFrCxk37uVZ4wM-=iwX3-Cn9j+uh1KneJoopVzia2nKTVA@mail.gmail.com>
 <87fuk4yg1i.fsf@free-electrons.com>
Message-ID: <CAPDyKFo-hpLd3W0zWykdg0swuciBeL=Cy9cur_0RoG8jApOh3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> OK, but maybe we could keep the part about the mmcard for the eMMC to
> emphasize that we need to setup this option for the controller.

Right!

>
>>> +
>>> +- no-1-8-v:
>>> +  Select this property when 1.8V signaling voltage supply is unavailable.
>>> +  When this property is enabled, both mmc-ddr-1_8v and mmc-hs400-1_8v should be
>>> +  cleared.
>>
>> Please don't use this sdhci property, unless really needed.
>
> Actually this is a mmc property, at least it is described in this the
> mmc binding:
> Documentation/devicetree/bindings/mmc/mmc.txt

Yes, the documentation is wrong. It should we be moved into the docs for sdhci.

I will send a patch updating it. Apologize for the misleading information.

>
> The description of this optional property is:
> "no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
>   this system, even if the controller claims it is."
>
> So as it is also part of the mmc binding we can remove it from our
> bindings as we are going to do it for the other mmc property.

Nope.

>
> But I am curious to know why do you think we could use it without any
> need. Are you aware of some abuse of this property?

Yes.

>
>>
>> Perhaps you can elaborate exactly why it makes sense for your case. Or
>> perhaps we already discussed this, in either case, please re-fresh my
>> mind.
>
> For instance we need it now on the 7040DB board which does not have the
> 1.8V signal voltage available.

It it's better to describe what the controller/board support, instead
of what it doesn't.

I think you should be able to use other existing mmc DT bindings
(perhaps also you need the brand new "mmc-ddr-3_3v"), instead of the
"no-1-8-v".

Kind regards
Uffe
