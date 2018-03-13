From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Tue, 13 Mar 2018 01:26:41 +0100
Subject: [PATCH v5 06/36] drm/rockchip: Only wait for panel ACK on PSR
 entry
In-Reply-To: <1909495.WV5cT3kS9W@diego>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-7-enric.balletbo@collabora.com>
 <1909495.WV5cT3kS9W@diego>
Message-ID: <804ab508-40b8-71fa-c40b-b54f70fcc453@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/03/18 17:58, Heiko St?bner wrote:
> Hi,
> 
> the subject is misleading I think, as this is touching only the generic
> bridge code and not anything Rockchip-related, so should probably
> be "drm/bridge"?
> 

Right, I'll fix this when I need to send another version, I'll wait, for now, a
bit more for reviews on the other patches.

Thanks
  Enric

> Am Freitag, 9. M?rz 2018, 23:22:57 CET schrieb Enric Balletbo i Serra:
>> From: zain wang <wzz@rock-chips.com>
>>
>> We currently wait for the panel to mirror our intended PSR state
>> before continuing on both PSR enter and PSR exit. This is really
>> only important to do when we're entering PSR, since we want to
>> be sure the last frame we pushed is being served from the panel's
>> internal fb before shutting down the soc blocks (vop/analogix).
>>
>> This patch changes the behavior such that we only wait for the
>> panel to complete the PSR transition when we're entering PSR, and
>> to skip verification when we're exiting.
>>
>> Cc: St?phane Marchesin <marcheu@chromium.org>
>> Cc: Sonny Rao <sonnyrao@chromium.org>
>> Signed-off-by: zain wang <wzz@rock-chips.com>
>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> change itself looks good, so
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
