From: ldufour@linux.vnet.ibm.com (Laurent Dufour)
Date: Mon, 9 Apr 2018 18:17:16 +0200
Subject: [PATCH 0/3] move __HAVE_ARCH_PTE_SPECIAL in Kconfig
In-Reply-To: <17b19aac-fed7-23a2-013c-43ca867152e9@synopsys.com>
References: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <17b19aac-fed7-23a2-013c-43ca867152e9@synopsys.com>
Message-ID: <21c34965-ec30-4d7f-aeaf-cb3da9758a0e@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2018 18:03, Vineet Gupta wrote:
> On 04/09/2018 06:57 AM, Laurent Dufour wrote:
>> The per architecture __HAVE_ARCH_PTE_SPECIAL is defined statically in the
>> per architecture header files. This doesn't allow to make other
>> configuration dependent on it.
> 
> So I understand this series has more "readability" value and I'm fine with this
> change but I wonder if you really would want to make something depend on it or
> make this de-configurable. PTE special is really a fundamental construct - e.g.
> it is used for anon mapped pages where zero page has been wired up etc...

I don't want it to be de-configurable. This is almost like
ARCH_SUPPORTS_MEMORY_FAILURE, ARCH_USES_HIGH_VMA_FLAGS, ARCH_HAS_HMM...

These values are selected by per architecture Kconfig files and are not exposed
through the configuration menu.

Concerning making something depend on it, I will probably make
CONFIG_SPECULATIVE_PAGE_FAULT introduced by the SPF series dependent on it.
For details, please see https://lkml.org/lkml/2018/3/13/1143

Thanks,
Laurent.
