From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 9 Mar 2018 20:05:07 -0500 (EST)
Subject: [PATCH 1/7] ARM: linker script: factor out some common definitions
 between XIP and non-XIP
In-Reply-To: <89d1d757-213c-4f47-af42-347ef27934d9@arm.com>
References: <20180309032100.31039-1-nicolas.pitre@linaro.org>
 <20180309032100.31039-2-nicolas.pitre@linaro.org>
 <89d1d757-213c-4f47-af42-347ef27934d9@arm.com>
Message-ID: <nycvar.YSQ.7.76.1803092001270.7678@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Mar 2018, Vladimir Murzin wrote:

> On 09/03/18 03:20, Nicolas Pitre wrote:
> > Lots of duplications between vmlinux.lds.S and vmlinux-xip.lds.S.
> > This may lead to one file being updated but not the other. For example,
> > SOFTIRQENTRY_TEXT and HYPERVISOR_TEXT were missing from the XIP version.
> 
> It looks to me that HYPERVISOR_TEXT was not present in the XIP version
> intentionally - XIP depends on !ARM_LPAE, i.e. not support for virtualisation.

Still... the !ARM_LPAE is an artificial dependency and there is no 
fundamental reason besides kconfig issues that would prevent XIP on 
LPAE.


Nicolas
