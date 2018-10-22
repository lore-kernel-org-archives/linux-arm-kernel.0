From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 22 Oct 2018 11:14:07 +0300
Subject: omap4: support for manually updated display
In-Reply-To: <20181020003812.GE43338@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com> <3205865.8O8aibZXye@avalon>
 <20180910174453.GV5662@atomide.com> <20181018221549.GB6364@amd>
 <20181019164450.GD43338@atomide.com>
 <20181019225827.s76wapp3cxrmp5af@earth.universe>
 <20181020003812.GE43338@atomide.com>
Message-ID: <6ebd84ad-3428-c2f5-da8b-e5b1c54ea5e2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/18 03:38, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [181019 15:58]:
>> I uploaded my current status here. It's not based on the newest
>> -next, but contains the interesting patches from Laurent. Also
>> the last few patches are not yet cleaned up, sorry for the mess.
> 
> Way to go, thanks :) Here's a quick fix for issues with loading
> and unloading modules, seems like this should be fixed somewhere
> else though?

I didn't get that far on drm-next with pandaboard. When loading modules, dsi_probe crashes. It is missing runtime_get(). But after adding runtime_get call, it fails and I see:

[   44.671081] omap_hwmod: dss_dsi2: _wait_target_ready failed: -16
[   44.677459] omapdss_dsi 58005000.encoder: use pm_runtime_put_sync_suspend() in driver?

Why is dsi2 busy (and what does it even mean)...

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
