From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 10 Aug 2017 13:15:43 +0100
Subject: [PATCH] drm: hdlcd: allow HDLCD to be used without interrupt
In-Reply-To: <20170726102748.GM31807@n2100.armlinux.org.uk>
References: <E1daJCF-0003pG-DI@rmk-PC.armlinux.org.uk>
 <20170726102748.GM31807@n2100.armlinux.org.uk>
Message-ID: <e68186a4-2435-a969-7eff-21556d6a6b03@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/17 11:27, Russell King - ARM Linux wrote:
> I suspect the above failure is down to either (a) not having enough
> memory available to allocate a 1920x1080 frame buffer, or (b) not
> (yet) being able to program the hdlcd pixel clock for this platform,
> which is currently hard-coded in DT at 23.75MHz.

Given it is NOMMU it is likely (a). Usually, tweaking FORCE_MAX_ZONEORDER
helped me in such cases.

Cheers
Vladimir
