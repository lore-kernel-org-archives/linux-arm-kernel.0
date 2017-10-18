From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 18 Oct 2017 17:58:28 +0200
Subject: [RFC v2 0/8] Acer Chromebook R13 support
In-Reply-To: <CAO3366wSii-P+=qzSO13-fqTUnXrx6DJ76+Bt1-wvYPOC8wNDA@mail.gmail.com>
References: <1508167900-27415-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <18d36386-d3a0-a81f-6240-9703a3d98fbd@gmail.com>
 <20171017160514.ivmaz6tzicoxewbx@art_vandelay>
 <CAO3366wSii-P+=qzSO13-fqTUnXrx6DJ76+Bt1-wvYPOC8wNDA@mail.gmail.com>
Message-ID: <a47fabef-1af8-4787-424b-9ff9cfb32f93@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/18/2017 04:53 PM, Ulrich Hecht wrote:
> On Tue, Oct 17, 2017 at 6:05 PM, Sean Paul <seanpaul@chromium.org> wrote:
>> On Tue, Oct 17, 2017 at 12:33:09PM +0200, Matthias Brugger wrote:
>>>  From what I understand you
>>> rebased the patches from the chromium kernel to mainline. So you should keep
>>> the signed-off-by from the original author and just add you signed-off-by
>>> below that.
>>> Also it would be nice to CC these persons so that they are aware of your effort.
>>>
>> Additionally, make sure the author and commit messages are preserved when you send
>> patches. You can add your own message in addition to your SoB, but please try to
>> preserve history.
> 
> Fair enough, but I'm not sure what exactly to include. The chromium
> commits include, among other things:
> 
> - bugtracker numbers and test cases
> - "Change-Id" and "Commit-Ready" (no idea what those are)
> - "Reviewed-on", containing links to chromium-review.googlesource.com
> 
> With all changes to the PS8640 driver concatenated and non-standard
> tags removed, the commit message would look like this:
> 
> =============================
>      CHROMIUM: drm/bridge: Add I2C based driver for ps8640 bridge

The ones that have a FROMLIST are actually backports taken from the mailinglist, 
so please search for them. Good starting point is linux-mediatek and 
linux-arm-kernel newsgroups.

For this patch the latest submission is these:
https://patchwork.kernel.org/patch/9427541/
https://patchwork.kernel.org/patch/9427543/

Please take up this patches and resubmit with the comments addressed by the 
reviewers.

Keep up the good work!
Matthias

> 
>      This patch adds drm_bridge driver for parade DSI to eDP bridge chip.
> 
>      Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>      (am from https://patchwork.kernel.org/patch/8357851/)
>      Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>      Tested-by: cawa cheng <cawa.cheng@mediatek.com>
>      Tested-by: Daniel Kurtz <djkurtz@chromium.org>
>      Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> 
> 
>      FIXUP: FROMLIST: drm/bridge: Add I2C based driver for ps8640 bridge
> 
>      chromeos-3.18 currently has FROMLIST v15 of the PS8640 driver.
>      This version is incompatible with UPSTREAM version of the Mediatek
>      DRM driver.
> 
>      To quote Philipp Zabel:
>      "The main DRM driver mtk_drm_drv now calls
>      drm_connector_register_all() after drm_dev_register() in the
>      mtk_drm_bind() function. That function should iterate over all
>      connectors and call drm_connector_register() for each of them.
>      The call to drm_connector_init() from mtk_hdmi_bridge_attach()
>      should be enough to make this happen.
> 
>      The drm_connector_(un)register calls also have to be removed
>      from the ps8640 driver."
> 
>      Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>      Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>      Tested-by: PC Liao <pc.liao@mediatek.com>
>      Tested-by: Daniel Kurtz <djkurtz@chromium.org>
>      Tested-by: Nicolas Boichat <drinkcat@chromium.org>
>      Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> 
>      CHROMIUM: drm/bridge: ps8640: Add a 3 ms delay before unmuting output
> 
>      For current ps8640 firmware, the PS_GPIO9 signal only indicates the bridge
>      has seen the attached panel's HPD signal and read its EDID.  Unfortunately,
>      the bridge may not yet be ready to properly handle DSI/eDP traffic yet.
> 
>      For now, Paradetech has recommended adding a 3 ms delay after PS_GPIO9
>      before starting video signal transmission.
> 
>      Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>      Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> 
>      Tested-by: cawa cheng <cawa.cheng@mediatek.com>
>      Tested-by: Daniel Kurtz <djkurtz@chromium.org>
>      Tested-by: jitao shi <jitao.shi@mediatek.com>
>      Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
>      Reviewed-by: jitao shi <jitao.shi@mediatek.com>
> 
> 
>      CHROMIUM: drm/bridge: ps8640: disable MIPI MCS
> 
>      Disable PS8640 MIPI MCS commands to workaround an issue where normal
>      MIPI DSI signals are sometimes recognized as an MSC command that can,
>      for example, disable the bridge output.
> 
>      Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>      Tested-by: Daniel Kurtz <djkurtz@chromium.org>
>      Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> 
>      CHROMIUM: drm/bridge: ps8640: Use individual regulators instead of bulk
> 
>      According to the latest information from Parade, the PS8640 1.2 V
>      supply must be enabled before 3.3 V.
>      So, split the bulk regulator into separate individual regulators that
>      can be enabled independently.
> 
>      Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> 
>      Tested-by: Daniel Kurtz <djkurtz@chromium.org>
>      Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> 
>      CHROMIUM: drm/bridge: ps8640: add 5ms delay between v12 and v33
> 
>      According to Parade, the PS8640 1.2V must be enabled 5 ms before its
>      3.3V. Otherwise, the PS8650 MCU may hang, and its settings cannot be
>      written correctly, leading to a black screen.
> 
>      Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>      Tested-by: Daniel Kurtz <djkurtz@chromium.org>
>      Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> =============================
> 
> That keeps chronology and attribution intact, but is somewhat
> redundant. Any suggestions on how to digest it? Or should I just add
> it as is?
> 
> CU
> Uli
> 
