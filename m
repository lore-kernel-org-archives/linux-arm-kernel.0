From: msalter@redhat.com (Mark Salter)
Date: Tue, 13 Aug 2013 09:57:08 -0400
Subject: [PATCH 06/16] Enforce minimum alignment of 1 page on
 allocations. The efi_high_alloc() and efi_low_alloc() functions use the
 EFI_ALLOCATE_ADDRESS option to the EFI function allocate_pages(), which
 requires a minimum of page alignment, and rejects all other requests.
In-Reply-To: <1376090777-20090-7-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-7-git-send-email-roy.franz@linaro.org>
Message-ID: <1376402228.27484.17.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> The existing code could fail to allocate depending
> on allocation size, as although repeated allocation
> attempts were made, none were guaranteed to be page
> aligned.
> 
> 
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---

Tested on arm64.

Acked-by: Mark Salter <msalter@redhat.com>
