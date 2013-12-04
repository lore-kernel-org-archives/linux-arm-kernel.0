From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Dec 2013 12:36:41 -0700
Subject: [PATCH v2] ARM: tegra: switch FUSE clock on before usage
In-Reply-To: <1385001613-19098-1-git-send-email-acourbot@nvidia.com>
References: <1385001613-19098-1-git-send-email-acourbot@nvidia.com>
Message-ID: <529F8449.3030604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 07:40 PM, Alexandre Courbot wrote:
> FUSE clock is enabled by most bootloaders, but we cannot expect it to be
> on in all contexts (e.g. kexec).
> 
> Ensure the FUSE clock is enabled before any of its registers is touched.
> Since FUSE is touched very early during system boot (before the clock
> devices are registered), directly manipulate the clock register bit in
> case the clock device cannot be acquired.

I've applied this to Tegra's for-3.14/soc branch.
