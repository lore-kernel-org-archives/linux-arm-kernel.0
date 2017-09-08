From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 8 Sep 2017 21:38:23 +0800
Subject: [PATCH 1/8] ARM: dts: sun6i: Fix endpoint IDs in second display
 pipeline
In-Reply-To: <20170908132932.rfz4hxab4tgntioo@flea.lan>
References: <20170908075016.18657-1-wens@csie.org>
 <20170908075016.18657-2-wens@csie.org>
 <20170908132932.rfz4hxab4tgntioo@flea.lan>
Message-ID: <CAGb2v64S9uifdR3H2OSzQP1GBWg0vW3B4_dA7yAOkhC7r15Tug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 8, 2017 at 9:29 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Sep 08, 2017 at 03:50:09PM +0800, Chen-Yu Tsai wrote:
>> When the second display pipeline device nodes for the A31/A31s were
>> added, it was not known that the TCONs could (through either DRCs)
>> select either backend as their input. Thus in the endpoints connecting
>> these components together, the endpoint IDs were set to 0, while in
>> fact they should have been set to 1.
>>
>> Fixes: 9a26882a7378 ("ARM: dts: sun6i: Add second display pipeline device
>>                     nodes")
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Should we CC stable on this one?

It wouldn't matter for old kernels, but I suppose we should get it right
everywhere, so we should probably CC stable. Also I forgot to mention
that this patch should go in -fixes, while the rest can go in -next.

Thanks
ChenYu
