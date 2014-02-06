From: horms@verge.net.au (Simon Horman)
Date: Thu, 6 Feb 2014 16:00:40 +0900
Subject: [PATCH 03/03] ARM: shmobile: Lager USB0 cable detection workaround
In-Reply-To: <20140129231029.22655.58864.sendpatchset@w520>
References: <20140129230959.22655.55645.sendpatchset@w520>
 <20140129231029.22655.58864.sendpatchset@w520>
Message-ID: <20140206070037.GF17591@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 08:10:29AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add Lager board code to check the PWEN GPIO signal and refuse to
> allow probe of the USBHS driver in case of DIP misconfiguration.
> 
> For correct operation Lager DIP switches SW5 and SW6 shall be
> configured in 2-3 position to enable USB Function support.
> 
> If the DIP switch is configured incorrectly then the user can
> simply adjust the hardware and either reboot or use the bind interface
> to try to probe again:
> 
> # echo renesas_usbhs > /sys/bus/platform/drivers/renesas_usbhs/bind
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queue this up.
