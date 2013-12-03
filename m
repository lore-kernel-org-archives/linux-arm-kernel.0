From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 3 Dec 2013 17:10:50 +0000
Subject: [PATCH v2] xen/block: Correctly define structures in public
 headers on ARM32 and ARM64
In-Reply-To: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
References: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
Message-ID: <529E109A.7050700@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/13 15:40, Julien Grall wrote:
> On ARM (32 bits and 64 bits), the double-word is 8-bytes aligned. This will
> result on different structure from Xen and Linux repositories.
> 
> As Linux is using __packed__ attribute, it must have a 4-bytes padding before
> each "id" field.
> 
> This change breaks guest block support with older kernel. IMHO, it's acceptable
> because Xen on ARM is still on Tech Preview and the hypercall ABI is not yet
> freezed.
> 
> Only one architecture (x86_32) doesn't have 64-bit ABI for the block interface.
> Don't add padding if Linux is compiled for this architecture.

I'm now satisfied that this is the right thing to do.

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
