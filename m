From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Jan 2014 22:43:01 +0100
Subject: [PATCH V2 5/6] power: reset: change xgene reboot driver to use
 both acpi and dts resource for reboot.
In-Reply-To: <1389135041-16062-6-git-send-email-fkan@apm.com>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <1389135041-16062-6-git-send-email-fkan@apm.com>
Message-ID: <201401082243.01694.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014, Feng Kan wrote:
> Enable the X-Gene reboot driver to use either the ACPI or the DTS
> resource using the platform driver method.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/power/reset/xgene-reboot.c |   33 ++++++++++++++++++++++++++++-----
>  1 files changed, 28 insertions(+), 5 deletions(-)
> 

Shouldn't an ACPI based system always be able to reboot through the
UEFI reset_system call? I really don't think we want to support
ACPI on non-UEFI systems.

	Arnd
