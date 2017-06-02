From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Jun 2017 15:13:39 +0100
Subject: [PATCH V17 02/11] ras: acpi/apei: cper: add support for generic
 data v3 structure
In-Reply-To: <1495225933-4410-3-git-send-email-tbaicar@codeaurora.org>
References: <1495225933-4410-1-git-send-email-tbaicar@codeaurora.org>
 <1495225933-4410-3-git-send-email-tbaicar@codeaurora.org>
Message-ID: <20170602141338.GJ6371@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 02:32:04PM -0600, Tyler Baicar wrote:
> The ACPI 6.1 spec adds a new revision of the generic error data
> entry structure. Add support to handle the new structure as well
> as properly verify and iterate through the generic data entries.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> CC: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c    | 11 +++++------
>  drivers/firmware/efi/cper.c | 37 ++++++++++++++++++++++---------------
>  include/acpi/ghes.h         | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+), 21 deletions(-)

Given that Boris and Rafael are ok with this series, it makes sense to
take this via arm64, but I need an ack from Ard or Matt on the EFI changes
in this patch and the subsequent one.

Will
