From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 15:00:57 -0700
Subject: [PATCH v2 05/11] ARM: dt: tegra30: Add device node for APB MISC
In-Reply-To: <1356619644-18565-6-git-send-email-pgaikwad@nvidia.com>
References: <1356619644-18565-1-git-send-email-pgaikwad@nvidia.com>
 <1356619644-18565-6-git-send-email-pgaikwad@nvidia.com>
Message-ID: <50E4AE19.1060503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/27/2012 07:47 AM, Prashant Gaikwad wrote:
> APB misc contains multiple registers required by different modules
> such as CAR.

I don't see a DT binding document that describes what
nvidia,tegra30-apbmisc means. Also, the register range for this new node
overlaps that for the pinmux node, so they can't both "request" their
register region. You may need multiple entries in the apbmisc reg
property to avoid this.
