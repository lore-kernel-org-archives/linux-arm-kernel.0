From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Aug 2015 08:47:00 -0500
Subject: [PATCH 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <874mjxwyx5.fsf@eliezer.anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-2-git-send-email-eric@anholt.net>
 <55CEC25E.7070303@wwwdotorg.org>
 <874mjxwyx5.fsf@eliezer.anholt.net>
Message-ID: <CAL_JsqJxiGUR5BxBPyR3-0NxqWsOxMGrWQA6cMXe2pjTom__nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 1:30 PM, Eric Anholt <eric@anholt.net> wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
>
>> On 08/12/2015 06:56 PM, Eric Anholt wrote:
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>
>> This one definitely needs a patch description, since someone might not
>> know what a VC4 is, and "git log" won't show the text from the binding
>> doc itself. I'd suggest adding the initial paragraph of the binding doc
>> as the patch description, or more.
>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
>
>>> +- hvss:             List of references to HVS video scalers
>>> +- encoders: List of references to output encoders (HDMI, SDTV)
>>
>> Would it make sense to make all those nodes child node of the vc4
>> object. That way, there's no need to have these lists of objects; they
>> can be automatically built up as the DT is enumerated. I know that e.g.
>> the NVIDIA Tegra host1x binding works this way, and I think it may have
>> been inspired by other similar cases.
>
> I've looked at tegra, and the component system used by msm appears to be
> nicer than it.  To follow tegra's model, it looks like I need to build
> this extra bus thing corresponding to host1x that is effectively the
> drivers/base/component.c code, so that I can get at vc4's structure from
> the component drivers.
>
>> Of course, this is only appropriate if the HW modules really are
>> logically children of the VC4 HW module. Perhaps they aren't. If they
>> aren't though, I wonder what this "vc4" module actually represents in HW?
>
> It's the subsystem, same as we use a subsystem node for msm, sti,
> rockchip, imx, and exynos.  This appears to be the common model of how
> the collection of graphics-related components is represented in the DT.

I think most of these bindings are wrong. They are grouped together
because that is what DRM wants not because that reflects the h/w. So
convince me this is one block, not that it is what other people do.

Rob
