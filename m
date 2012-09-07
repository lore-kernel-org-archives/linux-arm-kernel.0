From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2012 11:26:39 -0700
Subject: [PATCH] serial: omap: fix DeviceTree boot
In-Reply-To: <1347041433-11723-1-git-send-email-balbi@ti.com>
References: <20120907175721.GD1303@atomide.com>
 <1347041433-11723-1-git-send-email-balbi@ti.com>
Message-ID: <20120907182638.GJ1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120907 11:15]:
> OMAP Architecture code, passes a few function
> pointers for UART driver to use in order to
> properly implement Power Management and Wakeup
> capabilities.
> 
> The problem is that those function pointers,
> which are passed (ab)using platform_data on
> non-DT kernels, can't be passed down to drivers
> through DT.
> 
> commit e5b57c0 (serial: omap: define helpers
> for pdata function pointers) failed to take DT
> kernels into consideration and caused a regression
> to DT kernel boot.
> 
> Fix that by (re-)adding a check for valid pdata
> pointer together with valid pdata->$FUNCTION
> pointer.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Tony, does this solve the issue ?

Yes thanks console works again now:

Tested-by: Tony Lindgren <tony@atomide.com>
