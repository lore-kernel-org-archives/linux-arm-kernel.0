From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 15:15:20 +0100
Subject: [PATCH 12/20] ARM64 / ACPI: Use Parked Address in GIC structure
 for spin table SMP initialisation
In-Reply-To: <1389961514-13562-13-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-13-git-send-email-hanjun.guo@linaro.org>
Message-ID: <201401171515.21250.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 January 2014, Hanjun Guo wrote:
> +/* Parked Address in ACPI GIC structure */
> +static u64 parked_address[NR_CPUS];

Please use the per_cpu infrastructure rather than NR_CPUS long arrays.

	Arnd
