From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 12 Aug 2014 20:49:29 +0200
Subject: [PATCH 6/6] ARM: dts: Add tps65090 FETs constraints
In-Reply-To: <20140812172552.GU17528@sirena.org.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-7-git-send-email-javier.martinez@collabora.co.uk>
 <20140812172552.GU17528@sirena.org.uk>
Message-ID: <53EA61B9.2070805@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2014 07:25 PM, Mark Brown wrote:
> 
>>  		tps65090_fet1: fet1 {
>> +			regulator-min-microvolt = <5000000>;
>> +			regulator-max-microvolt = <17000000>;
>>  		};
> 
> No, this is completely broken and exactly the sort of thing that makes
> doing generic device .dtsi a bad idea.  We have absolutely no idea if
> these voltage ranges are suitable for use on a given board using the
> device, these are the design limits for the device but tell us nothing
> about the system they are deployed in.
> 

Thanks for the explanation. I did the refactoring because I saw that there are
.dtsi files for other PMICs already (twl4030, twl6030, tps65*) but now you also
explained that those are broken as well.

So, is adding these voltages ranges (the design limits) in the Peach Pit DTS
file directly an acceptable solution? Basically what my previous patch [0] did.

That matches what is in the board schematic so I assume that it's safe to use
these voltage ranges for that machine. If so I'll drop this series and repost
that patch fixing the typo error and commit message pointed by Doug that were
already addressed in $subject.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/8/11/204
