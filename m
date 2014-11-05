From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 05 Nov 2014 18:28:45 +0800
Subject: [Patch Part2 v4 00/31] Enable hierarchy irqdomian on x86 platforms
In-Reply-To: <20141105095850.GH10744@8bytes.org>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
 <20141104144730.GE14512@8bytes.org> <5458ECF3.4040308@linux.intel.com>
 <20141105085154.GG10744@8bytes.org> <5459F0DE.6000307@linux.intel.com>
 <20141105095850.GH10744@8bytes.org>
Message-ID: <5459FBDD.4020504@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,
	Seems like a silly bug, could you please help to try this
fix?
Regards!
Gerry
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7423ee16972f..62ba8a6f6e79 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1211,7 +1211,7 @@ int msi_irq_domain_alloc_irqs(struct irq_domain
*domain, int type,
                                msidesc->nvec_used > 1) ?  1 : -ENOSPC;
                }
                for (i = 0; i < msidesc->nvec_used; i++)
-                       irq_set_msi_desc_off(virq + i, i, msidesc);
+                       irq_set_msi_desc_off(virq, i, msidesc);
        }

        list_for_each_entry(msidesc, &dev->msi_list, list)

On 2014/11/5 17:58, Joerg Roedel wrote:
> On Wed, Nov 05, 2014 at 05:41:50PM +0800, Jiang Liu wrote:
>> 	Could you please help to apply the attached patch and send me
>> console outputs?
> 
> Sure, here it is.
> 
