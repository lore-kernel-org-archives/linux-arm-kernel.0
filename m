From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Dec 2013 12:37:00 -0700
Subject: [PATCH 1/3] ARM: tegra: fix DEBUG_LL combined with LPAE
In-Reply-To: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
References: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <529F845C.3020402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 03:36 PM, Stephen Warren wrote:
> The DEBUG_LL UART address is mapped as an MMU section, hence, the
> virtual address must be section-aligned. Sections are 1MB without LPAE
> and 2MB with LPAE. Tegra's virtual address was only aligned to 1MB, and
> hence the mapping was set up incorrectly with LPAE enabled, thus causing
> a hang early during boot. Fix this by picking a different virtual address
> that is aligned to 2MB.

I've applied this series to Tegra's for-3.14/soc branch.
