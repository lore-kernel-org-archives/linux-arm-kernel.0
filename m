From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Mar 2013 10:47:31 -0700
Subject: [PATCH] ARM: DT: tegra20/tegra30: Correct clock id for UARTB
In-Reply-To: <1362751245-32432-1-git-send-email-ldewangan@nvidia.com>
References: <1362751245-32432-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <513A2433.2080002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 07:00 AM, Laxman Dewangan wrote:
> UARTB clock bit in CAR register is 7. Correcting this
> in DTS file.

The register bit is 7, but the clock ID in the Tegra CAR DT binding is
96 for UART2 or 97 for VFIR. This was due to there being 1 clock bit and
2 separate IP block reset bits, or the other way around, so we highlight
the issue by assigning different clock IDs. See the comment before the
list of clock IDs in the binding document.
