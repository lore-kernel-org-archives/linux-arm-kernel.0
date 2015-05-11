From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 May 2015 23:49:34 +0100
Subject: [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
In-Reply-To: <1431384089-28367-2-git-send-email-robh@kernel.org>
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
 <1431384089-28367-2-git-send-email-robh@kernel.org>
Message-ID: <20150511224934.GL2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 05:41:26PM -0500, Rob Herring wrote:
> Add the memory resource for the sa1100-rtc device. Since the memory
> resource is already present in the pxa_rtc_resources, that makes
> sa1100_rtc_resources and pxa_rtc_resources equivalent, so use
> pxa_rtc_resources for both devices and remove the duplicate
> sa1100_rtc_resources.

This really isn't a good idea - what do you think happens when
the same struct resource gets passed into insert_resource()
twice?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
