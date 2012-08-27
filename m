From: ian.molton@codethink.co.uk (Ian Molton)
Date: Mon, 27 Aug 2012 11:25:20 +0200
Subject: [PATCH 5/6] arm: mvebu: add Aurora L2 Cache Controller to the DT
In-Reply-To: <50379A96.1050409@free-electrons.com>
References: <1345799361-23735-1-git-send-email-gregory.clement@free-electrons.com>
 <1345799361-23735-6-git-send-email-gregory.clement@free-electrons.com>
 <50379609.1020006@codethink.co.uk> <50379A96.1050409@free-electrons.com>
Message-ID: <503B3D00.2000500@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/12 17:15, Gregory CLEMENT wrote:
> On 08/24/2012 04:56 PM, Ian Molton wrote:> On 24/08/12 11:09, Gregory CLEMENT wrote:
>>> + compatible = "marvell,aurora-cache-with-outer";
>> This reads wrong.
>>
>> perhaps aurora-with-outer-cache?
> We can use
> compatible = "marvell,aurora-outer-cache"
> and
> compatible = "marvell,aurora-system-cache"
>
> which is a better description of the L2 cache controller indeed.

Yes, much clearer.

> I guess you meant:
>
> compatible = "marvell,armada370", "marvell,armada-370-xp";
>     L2: l2-cache {										
>         compatible = "marvell,aurora-cache";
>         reg = <0xd0008000 0x1000>;
>         cache-id-part = <0x100>;
>         wt-override;
>         with-outer="yes";
>     };

Yes :)

-Ian
