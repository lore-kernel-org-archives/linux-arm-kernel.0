From: omycle@gmail.com (Li Haifeng)
Date: Sun, 8 Jul 2012 22:47:26 +0800
Subject: After v2.6.38, is it necessary for modify_domain on ARMv7 core?
Message-ID: <CAFNq8R6bxR8gv+m9VCz8g2kyf1oas68_601vwdzs_A8mK7wqsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King.

Thanks for your memory domain explanation at former email. Now I am
still confusing about this topic.

After 2.6.38. CONFIG_CPU_USE_DOMAINS is added. When this configuration
entry is enabled, the value of  DOMAIN_MANAGER is equal to
DOMAIN_CLIENT,

arch/arm/include/asm/domain.h:
#define DOMAIN_CLIENT   1
#ifdef CONFIG_CPU_USE_DOMAINS
#define DOMAIN_MANAGER  3
#else
#define DOMAIN_MANAGER  1
#endif

For ARMV7, because CONFIG_CPU_USE_DOMAINS is disable in Kernel, no
matter the attribute of memory's domain is DOMAIN_CLIENT and
DOMAIN_MANAGER, the AP will be checked while access memory.

So, maybe modify_domain is unnecessary after Kernel v2.6.38. e.g.
switching processes, copy_strings_kernel.

Is it right?
