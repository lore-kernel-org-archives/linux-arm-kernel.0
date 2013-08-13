From: msalter@redhat.com (Mark Salter)
Date: Tue, 13 Aug 2013 09:56:29 -0400
Subject: [PATCH 02/16] Add system pointer argument to shared EFI stub
 related functions so they no longer use global system table pointer as they
 did when part of eboot.c. This code is now shared, so using a global
 variable as part of the interface is not that nice. Also, by avoiding any
 global variables in the ARM EFI stub, this allows the code to be position
 independent without requiring GOT fixups.
In-Reply-To: <1376090777-20090-3-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-3-git-send-email-roy.franz@linaro.org>
Message-ID: <1376402189.27484.13.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---
>  arch/x86/boot/compressed/eboot.c       |   38 +++++++------
>  drivers/firmware/efi/efi-stub-helper.c |   96 +++++++++++++++++---------------
>  2 files changed, 72 insertions(+), 62 deletions(-)

Tested on arm64.

Acked-by: Mark Salter <msalter@redhat.com>
