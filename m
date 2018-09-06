From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 5 Sep 2018 21:12:51 -0700
Subject: [linux-sunxi] [PATCH v4 11/11] arm64: dts: allwinner: a64: Enable
 HDMI output on A64 boards w/ HDMI
In-Reply-To: <CA+E=qVdWXWztLj3989X+U+=4P5FpM4hs+6ByVmq8bf7mPeiWsA@mail.gmail.com>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-12-icenowy@aosc.io>
 <CAMty3ZCvpUf0nJ3WuPccP8BizBP=Uc8ChzB8SeN8fkX2iS1E_Q@mail.gmail.com>
 <20180905075136.chumwosx76o2n66l@flea>
 <CAMty3ZAVr_d+Rwry_DMWY221OC+YSWmReNm-TXzYWgpd1s68+w@mail.gmail.com>
 <CA+E=qVdWXWztLj3989X+U+=4P5FpM4hs+6ByVmq8bf7mPeiWsA@mail.gmail.com>
Message-ID: <CA+E=qVd4siJReWxbEeQ1DjFrTnewSGW=UJitduLT=52YfB-rag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 3:53 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> I can test it tonight.

It works fine for me on pine64-lts with HDMI monitor:

[    1.969772] sun4i-drm display-engine: bound 1100000.mixer (ops
sun8i_mixer_ops)
[    1.979302] sun4i-drm display-engine: bound 1200000.mixer (ops
sun8i_mixer_ops)
[    1.979738] sun4i-drm display-engine: No panel or bridge found...
RGB output disabled
[    1.979755] sun4i-drm display-engine: bound 1c0c000.lcd-controller
(ops sun4i_tcon_ops)
[    1.979935] sun4i-drm display-engine: bound 1c0d000.lcd-controller
(ops sun4i_tcon_ops)
[    1.980017] sun4i-drm display-engine: failed to bind 1ee0000.hdmi
(ops sun8i_dw_hdmi_ops): -517
[    1.980306] sun4i-drm display-engine: Couldn't bind all pipelines components
[    1.980446] sun4i-drm display-engine: master bind failed: -517
[    4.230997] sun4i-drm display-engine: bound 1100000.mixer (ops
sun8i_mixer_ops)
[    4.247886] sun4i-drm display-engine: bound 1200000.mixer (ops
sun8i_mixer_ops)
[    4.255639] sun4i-drm display-engine: No panel or bridge found...
RGB output disabled
[    4.263482] sun4i-drm display-engine: bound 1c0c000.lcd-controller
(ops sun4i_tcon_ops)
[    4.283255] sun4i-drm display-engine: bound 1c0d000.lcd-controller
(ops sun4i_tcon_ops)
[    4.322055] sun4i-drm display-engine: bound 1ee0000.hdmi (ops
sun8i_dw_hdmi_ops)
[    4.342115] fb: switching to sun4i-drm-fb from simple
[    5.001434] sun4i-drm display-engine: fb0: DRM emulated frame buffer device
[    5.008933] [drm] Initialized sun4i-drm 1.0.0 20150629 for
display-engine on minor 0

I tested non-applied patches from this series on top of
git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
sunxi/for-next

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

>
> On Wed, Sep 5, 2018 at 12:57 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>> On Wed, Sep 5, 2018 at 1:21 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>>> On Wed, Sep 05, 2018 at 12:56:03PM +0530, Jagan Teki wrote:
>>>> On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>>>> > From: Jagan Teki <jagan@amarulasolutions.com>
>>>> >
>>>> > Enable all necessary device tree nodes and add connector node to device
>>>> > trees for all supported A64 boards with HDMI.
>>>> >
>>>> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>> > [Icenowy: squash all board patches altogether and change supply name]
>>>> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>> > ---
>>>> > Changes in v4:
>>>> > - Rebase some device trees.
>>>> > Changes in v3,1:
>>>> > - Squash all enablement patches altogether.
>>>> > - Change supply name to match DT binding & driver change.
>>>> > Changes for v3:
>>>> > - Enable all pipeline components
>>>> > Changes for v2:
>>>> > - none
>>>> >
>>>> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
>>>> >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
>>>> >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
>>>> >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
>>>> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
>>>> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
>>>> >  6 files changed, 204 insertions(+)
>>>>
>>>> Tested-by: Jagan Teki <jagan@amarulasolutions.com> # BPI-M64, OPI-Win,
>>>> A64-Olinuxino, NPI-A64
>>>>
>>>> Pine64 boards look unable by saying
>>>> [drm] Cannot find any crtc or sizes
>>>>
>>>> May be someone can confirm, it.
>>>
>>> Then we should drop the pine64 additions until someone figures it out,
>>> as it has been already discussed.
>>
>> That is fine, but If anyone have pine64 can confirm this.
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
