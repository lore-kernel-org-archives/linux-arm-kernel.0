From: bsingharora@gmail.com (Balbir Singh)
Date: Mon, 2 May 2016 11:05:25 +1000
Subject: [RFC 1/5] powerpc: Rename context.vdso_base to context.vdso
In-Reply-To: <1461856737-17071-2-git-send-email-cov@codeaurora.org>
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
 <1461856737-17071-2-git-send-email-cov@codeaurora.org>
Message-ID: <5726A7D5.7030305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/04/16 01:18, Christopher Covington wrote:
> In order to share remap and unmap support for the VDSO with other
> architectures without duplicating the code, we need a common name and type
> for the address of the VDSO. An informal survey of the architectures
> indicates unsigned long vdso is popular. Change the variable name in
> powerpc from mm->context.vdso_base to simply mm->context.vdso.
> 

Could you please provide additional details on why the remap/unmap operations are required?
This patch does rename, but should it abstract via a function acesss to vmap field using arch_* operations? Not sure

Balbir Singh
