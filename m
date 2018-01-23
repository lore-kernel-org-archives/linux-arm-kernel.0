From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 23 Jan 2018 14:19:19 +0800
Subject: [PATCH] ARM: sunxi_defconfig: Enable CMA
In-Reply-To: <20180122073400.gplq23xai7rlt3jp@flea.lan>
References: <20180119133208.12873-1-maxime.ripard@free-electrons.com>
 <CAGb2v67wwa30E2GFaWEuLe1fEvCBmEy7H_3ystv460+1SAJGuA@mail.gmail.com>
 <20180122073400.gplq23xai7rlt3jp@flea.lan>
Message-ID: <CAGb2v67Gr5zdSO9oxARhRsDYJ0spVP0aNAO=yC2h_s28U8nyeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 3:34 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sat, Jan 20, 2018 at 11:37:28AM +0800, Chen-Yu Tsai wrote:
>> On Fri, Jan 19, 2018 at 9:32 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > The DRM driver most notably, but also out of tree drivers (for now) like
>> > the VPU or GPU drivers, are quite big consumers of large, contiguous memory
>> > buffers. However, the sunxi_defconfig doesn't enable CMA in order to
>> > mitigate that, which makes them almost unusable.
>> >
>> > Enable it to make sure it somewhat works.
>>
>> IIRC the default size for CMA pretty much limits it to small tablet
>> screen resolutions. Is this something we want to leave up to the
>> user?
>
> That's one of the pain points of CMA in our case. The amount of memory
> you need depends on the resolution itself, but also the number of
> multiple buffers you want to use, and even the number of planes you
> want to use.
>
> And then, you have to trade that off with the amount of RAM you have
> on your board in order to still have something that's usable.
>
> tl;dr: I don't really see how to define a value good enough for
> everyone.

Yeah, that's what I thought. On the other hand, I don't think any
of the kernelci boards have display enabled? So either way we won't
see any automated tests fail.

ChenYu
