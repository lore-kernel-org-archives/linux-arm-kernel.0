From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 12 Dec 2016 14:35:41 +0100
Subject: [PATCH] ASoC: samsung: Remove tests of member address
In-Reply-To: <1481363471-21364-1-git-send-email-krzk@kernel.org>
References: <1481363471-21364-1-git-send-email-krzk@kernel.org>
Message-ID: <2863148.52BcI6omVF@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, December 10, 2016 11:51:11 AM Krzysztof Kozlowski wrote:
> The driver was checking for non-NULL address of struct's members:
>  - s3c_audio_pdata->type (union),
>  - s3c_audio_pdata->type.i2s (embedded struct).
> 
> This is pointless as these will be always non-NULL.  The 's3c_audio_pdata'
> is always initialized in static memory so it will be zeroed.
> Additionally the 'type' member was an union with only one member.
> 
> It is safe to reorganize the structures to get rid of useless union and
> checks for addresses to fix the coccinelle warning:
> 	>> sound/soc/samsung/i2s.c:1270:2-4: ERROR: test of a variable/field address
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
