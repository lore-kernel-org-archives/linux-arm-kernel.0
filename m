From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Nov 2013 13:30:16 -0700
Subject: [PATCH v2] ARM: tegra: switch FUSE clock on before usage
In-Reply-To: <1385001613-19098-1-git-send-email-acourbot@nvidia.com>
References: <1385001613-19098-1-git-send-email-acourbot@nvidia.com>
Message-ID: <528E6D58.6050503@wwwdotorg.org>
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

This looks reasonable to me. I'll apply it soon after -rc1.
