From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 19 Apr 2016 10:43:03 +0800
Subject: [PATCH] drm/rockchip: get rid of rockchip_drm_crtc_mode_config
In-Reply-To: <20160418102538.0ed730ca.john@metanate.com>
References: <1460948611-32259-1-git-send-email-mark.yao@rock-chips.com>
 <20160418102538.0ed730ca.john@metanate.com>
Message-ID: <57159B37.9050806@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?04?18? 17:25, John Keeping wrote:
> On Mon, 18 Apr 2016 11:03:31 +0800, Mark Yao wrote:
>
>> >We need to take care of the vop status when use
>> >rockchip_drm_crtc_mode_config, if vop is disabled,
>> >the function would failed, that is terrible.
>> >
>> >Save connector type and output mode on drm_display_mode->private_flags
>> >at encoder mode_fixup, then we can configure the type and mode safely
>> >on crtc mode_set.
> Since Rockchip is atomic, shouldn't this be using atomic_check hooks and
> a subclassed crtc_state structure?
>
Hi John

I try to use atomic_check with crtc_state, but it seems not easy,
there are two value need transmit from connector to vop: connector type 
and out_mode

the connector type I think we can loop the atomic state to find the 
connector type.
but the out_mode is a custom value, I can't find a generic way to 
transmit it with atomic state.

BTW, I think on atomic side, the drm_display_mode is under control by 
atomic state,
and the mode->private_flags is not use by drm framework, I found i915 
and gma500 also use
mode->private_flags to transmit custom value.

So I think it's no problem using mode->private_flags.

-- 
?ark Yao
