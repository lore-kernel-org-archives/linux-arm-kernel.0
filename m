From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2015 16:17:14 +0100
Subject: [RFC PATCH v3 4/4] drm/armada: Convert the probe function to the
 generic drm_of_component_probe()
In-Reply-To: <1445267270-23126-5-git-send-email-Liviu.Dudau@arm.com>
References: <1445267270-23126-1-git-send-email-Liviu.Dudau@arm.com>
 <1445267270-23126-5-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20151019151714.GI32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 04:07:50PM +0100, Liviu Dudau wrote:
> The armada DRM driver keeps some old platform data compatibility in the
> probe function that makes moving to the generic drm_of_component_probe()
> a bit more complicated that it should. Refactor the probe function to do
> the platform_data processing after the generic probe (and only if that
> fails). This way future cleanup can further remove support for it.

I'm mainly using the old code, even with DT based platforms, because it
needs a block of reserved memory which I haven't got around to converting
to DT stuff (each time I've looked into doing that, bits for dealing with
reserved memory nodes were missing.)

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
