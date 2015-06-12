From: sumit.saxena@avagotech.com (Sumit Saxena)
Date: Fri, 12 Jun 2015 13:45:45 +0530
Subject: [V6 PATCH 6/7] megaraid_sas: fix TRUE and FALSE re-define build
 error
In-Reply-To: <1433952538-22455-7-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1433952538-22455-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1433952538-22455-7-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <dc59149b1904c1164abfcc567741c4e6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Suravee Suthikulpanit [mailto:Suravee.Suthikulpanit at amd.com]
>Sent: Wednesday, June 10, 2015 9:39 PM
>To: rjw at rjwysocki.net; lenb at kernel.org; catalin.marinas at arm.com;
>will.deacon at arm.com; thomas.lendacky at amd.com;
>herbert at gondor.apana.org.au; davem at davemloft.net; arnd at arndb.de;
>kashyap.desai at avagotech.com; sumit.saxena at avagotech.com;
>uday.lingala at avagotech.com; vinholikatti at gmail.com
>Cc: msalter at redhat.com; hanjun.guo at linaro.org; al.stone at linaro.org;
>grant.likely at linaro.org; leo.duran at amd.com; linux-arm-
>kernel at lists.infradead.org; linux-acpi at vger.kernel.org; linux-
>kernel at vger.kernel.org; linaro-acpi at lists.linaro.org;
netdev at vger.kernel.org;
>linux-crypto at vger.kernel.org; Suravee Suthikulpanit
>Subject: [V6 PATCH 6/7] megaraid_sas: fix TRUE and FALSE re-define build
>error
>
>Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>Cc: Kashyap Desai <kashyap.desai@avagotech.com>
>Cc: Sumit Saxena <sumit.saxena@avagotech.com>
>Cc: Uday Lingala <uday.lingala@avagotech.com>
>---
> drivers/scsi/megaraid/megaraid_sas_fp.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c
>b/drivers/scsi/megaraid/megaraid_sas_fp.c
>index 4f72287..e8b7a69 100644
>--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
>+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
>@@ -66,7 +66,15 @@ MODULE_PARM_DESC(lb_pending_cmds, "Change
>raid-1 load balancing outstanding "
>
> #define ABS_DIFF(a, b)   (((a) > (b)) ? ((a) - (b)) : ((b) - (a)))
> #define MR_LD_STATE_OPTIMAL 3
>+
>+#ifdef FALSE
>+#undef FALSE
>+#endif
> #define FALSE 0
>+
>+#ifdef TRUE
>+#undef TRUE
>+#endif
> #define TRUE 1
>
> #define SPAN_DEBUG 0
Acked-by: Sumit Saxena <sumit.saxena@avagotech.com>

>--
>2.1.0
