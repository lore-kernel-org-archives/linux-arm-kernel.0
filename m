From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 18 Apr 2016 17:54:09 +0800
Subject: [PATCH] drm/rockchip: get rid of rockchip_drm_crtc_mode_config
In-Reply-To: <20160418102538.0ed730ca.john@metanate.com>
References: <1460948611-32259-1-git-send-email-mark.yao@rock-chips.com>
 <20160418102538.0ed730ca.john@metanate.com>
Message-ID: <5714AEC1.7050409@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?04?18? 17:25, John Keeping wrote:
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

Right, Good idea.

Thanks.

-- 
?ark Yao
