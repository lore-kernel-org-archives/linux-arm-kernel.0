From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 10 Aug 2018 09:49:16 +0200
Subject: [PATCH 4/4] drm/meson: convert to the new canvas module
In-Reply-To: <CAHStOZ6oemCwYWb7dW6SS_ZaWEiVWSfrF=dB_G6CkVb6KS96nA@mail.gmail.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-5-maxi.jourdan@wanadoo.fr>
 <5b6cc316.1c69fb81.682d3.1216@mx.google.com>
 <CAHStOZ6oemCwYWb7dW6SS_ZaWEiVWSfrF=dB_G6CkVb6KS96nA@mail.gmail.com>
Message-ID: <e95fe817-ef12-9d06-e7c3-af2a959a2443@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2018 08:35, Maxime Jourdan wrote:
> 2018-08-10 0:41 GMT+02:00 Rob Herring <robh@kernel.org>:
>> Hi, this is an automated email from Rob's (experimental) review bot. I
>> found a couple of common problems with your patch. Please see below.
>>
>> On Wed,  1 Aug 2018 20:51:28 +0200, Maxime Jourdan wrote:
>>> This removes the meson_canvas files within the meson/drm layer
>>> and makes use of the new canvas module that is referenced in the dts.
>>>
>>> Canvases can be used by different IPs and modules, and it is as such
>>> preferable to rely on a module that can safely dispatch canvases on
>>> demand.
>>>
>>> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>>
>> The preferred subject prefix is "dt-bindings: <binding dir>: ...".
>>
>>> ---
>>>  .../bindings/display/amlogic,meson-vpu.txt    |  9 +--
>>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  7 +-
>>>  drivers/gpu/drm/meson/Kconfig                 |  1 +
>>>  drivers/gpu/drm/meson/Makefile                |  2 +-
>>>  drivers/gpu/drm/meson/meson_canvas.c          | 70 -------------------
>>>  drivers/gpu/drm/meson/meson_canvas.h          | 42 -----------
>>>  drivers/gpu/drm/meson/meson_crtc.c            |  5 +-
>>>  drivers/gpu/drm/meson/meson_drv.c             | 35 ++++++----
>>>  drivers/gpu/drm/meson/meson_drv.h             |  5 +-
>>>  drivers/gpu/drm/meson/meson_plane.c           |  3 +-
>>>  drivers/gpu/drm/meson/meson_viu.c             |  1 -
>>>  11 files changed, 39 insertions(+), 141 deletions(-)
>>>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
>>>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h
>>>
>>
>> DT bindings (including binding headers) should be a separate patch. See
>> Documentation/devicetree/bindings/submitting-patches.txt.
>>
> 
> Hi, What's the standard procedure here ? The reason I kept
> devicetree+drm changes together is because I didn't want to have
> floating commits that would break the drm module.
> 
> Should I split the changes anyway ?
> 
> Maxime
> 

Yep, split the dt-bindings and the code change.

In a non-perfect work, it could be great to keep the "old" canvas until
everything is merged, except if Kevin let me merge everything (including DT) in drm-misc.

Neil
