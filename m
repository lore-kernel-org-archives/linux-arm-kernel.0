From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 2 Aug 2016 11:41:46 +0530
Subject: [RFT PATCH v2 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from being
 selected redundantly
In-Reply-To: <20160801152430.GM5783@n2100.arm.linux.org.uk>
References: <1470049950-4697-1-git-send-email-kishon@ti.com>
 <1470049950-4697-3-git-send-email-kishon@ti.com>
 <20160801152430.GM5783@n2100.arm.linux.org.uk>
Message-ID: <57A039A2.7030406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 01 August 2016 08:54 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 01, 2016 at 04:42:29PM +0530, Kishon Vijay Abraham I wrote:
>> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
>> Fix it from getting redundantly selected in all
>> ARCH_MULTIPLATFORM based machines.
> 
> You're changing more than just platforms that are part of
> ARCH_MULTIPLATFORM.  Eg, ARCH_DOVE and ARCH_IXP4XX.  So, these will
> probably end up losing PCI support as a result of this change.

Okay. Initially assumed ARCH_MULTIPLATFORM will be set if MMU is set. But looks
like that's not true for some of the platforms. Will fix it and resend the series.

Thanks
Kishon
