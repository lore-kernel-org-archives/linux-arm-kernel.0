From: prakity@nvidia.com (Philip Rakity)
Date: Wed, 17 Oct 2012 21:56:32 +0200
Subject: [PATCH 1/2] mmc: core: Support all MMC capabilities when
 booting from Device Tree
In-Reply-To: <201210171338.01011.arnd@arndb.de>
References: <1350306959-5843-1-git-send-email-lee.jones@linaro.org>
 <201210151420.29930.arnd@arndb.de> <20121015160740.GC7662@gmail.com>
 <201210171338.01011.arnd@arndb.de>
Message-ID: <1B3089FB-EDBE-4145-83A6-1DFA4B0A2FDF@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 17 Oct 2012, at 14:38, Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 15 October 2012, Lee Jones wrote:
>>> and so on. What are you actually missing in the properties that
>>> are already there?
>> 
>> MMC_CAP_ERASE
> 
> This one seems to be set unconditionally on some controllers but
> not on others. Why would it need to be configurable?
> 
>> MMC_CAP_UHS_SDR12
>> MMC_CAP_UHS_SDR25
>> MMC_CAP_UHS_DDR50
> 
> Could this be derived from max-frequency?

The problem is the controller may signal it supports DDR but the host cannot.  For example no voltage at correct level.
Same issue with 8 bit support.  Controller could say supports it but board has only 4 "wires"
> 
>> MMC_CAP_1_8V_DDR
> 
> Right, I suppose we need this. Should we have a minimum and maximum
> voltage added to the common properties for this?
> 
>> MMC_CAP2_DETECT_ON_ERR
>> MMC_CAP2_NO_SLEEP_CMD
> 
> I don't see these ones being set anywhere, but they were both
> added by Ulf. Maybe he can comment on if or why they are needed
> in devicetree, rather than being set by the driver unconditionally
> or for specific versions of the host controller.
> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
