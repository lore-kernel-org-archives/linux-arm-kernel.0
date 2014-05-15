From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 May 2014 14:39:07 -0600
Subject: [RFC PATCH 05/10] ARM: tegra: Export function to read USB
 calibration data
In-Reply-To: <1400113986-339-6-git-send-email-abrestic@chromium.org>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
 <1400113986-339-6-git-send-email-abrestic@chromium.org>
Message-ID: <537525EB.9090704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 06:33 PM, Andrew Bresticker wrote:
> Board-specific USB configuration data is stored in FUSE_SKU_CALIB_0.
> Export a function to read it so the PHY can be properly configured.

This patch seems conceptually fine to me. Presumably once Peter's fuse
driver is fleshed out, it can expose the exact same semantic interface
to drivers.

I suppose one could argue that we should create/use an explicit fuse
subsystem with a standard API that drivers can call into, rather than a
custom API. We can get the appropriate handle to use for that API from a
phandle (plus fuse IDs?) in a DT property (in the XHCI device node,
pointing at the fuse device node) much like any other cross-device
resource reference. I'm not too bothered whether the code actually does
that in the first instance, although we should make sure we add that DT
property (containing all required fuse ID information) so that the code
/can/ work that way if we want it to in the future.
