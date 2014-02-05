From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Feb 2014 11:42:36 -0700
Subject: [PATCH v3 4/6] ARM: tegra: Add efuse bindings
In-Reply-To: <1390952176-30402-5-git-send-email-pdeschrijver@nvidia.com>
References: <1390952176-30402-1-git-send-email-pdeschrijver@nvidia.com>
 <1390952176-30402-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52F2861C.4010109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 04:36 PM, Peter De Schrijver wrote:
> Add efuse bindings for Tegra20, Tegra30, Tegra114 and Tegra124.

> diff --git a/Documentation/devicetree/bindings/fuse/fuse-tegra.txt b/Documentation/devicetree/bindings/fuse/fuse-tegra.txt

> +- clocks: Should contain a pointer to the fuse clock.

I would prefer to use clock-names, and to follow the same text as all
the other Tegra bindings that are clock clients. In other words:

  - clocks: Must contain an entry for each entry in clock-names.
    See ../clocks/clock-bindings.txt for details.
  - clock-names: Must include the following entries:
    - fuse

(this will allow easy future changes to the binding if required)
