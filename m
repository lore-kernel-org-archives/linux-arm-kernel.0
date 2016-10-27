From: david@lechnology.com (David Lechner)
Date: Wed, 26 Oct 2016 19:28:37 -0500
Subject: [PATCH] ARM: davinci: Add full regulator constraints for non-DT
 boot
In-Reply-To: <20161026194155.14304-1-ahaslam@baylibre.com>
References: <20161026194155.14304-1-ahaslam@baylibre.com>
Message-ID: <6831ba9f-12a6-81fc-f34c-7e658f154cd6@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2016 02:41 PM, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
>
> The phy framework requests an optional "phy" regulator. If it does
> not find one, it returns -EPROBE_DEFER. In the case of non-DT boot
> for the omap138-lcdk board, this would prevent the usb11 phy to probe
> correctly and ohci would not enumerate.
>
> By calling "regulator_has_full_constraints", An error would be returned
> instead of DEFER for the regulator, and the probe of the phy driver can
> continue normally without a regulator.
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>
> This applies cleanly after David's recent patches:
>
> [PATCH v6 0/5] da8xx USB PHY platform devices and clocks
> https://lkml.org/lkml/2016/10/25/867
>

Applies cleanly on v7 as well. And actually, this should apply cleanly 
even without my patches.
