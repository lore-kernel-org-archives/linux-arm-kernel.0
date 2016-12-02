From: dhdang@apm.com (Duc Dang)
Date: Thu, 1 Dec 2016 22:42:25 -0800
Subject: [Linaro-acpi] [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI
 controller for ThunderX pass2.x silicon version
In-Reply-To: <e5b1f09c-ca4c-fbf0-e9d7-c943ad0df2ff@redhat.com>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
 <1479201298-25494-2-git-send-email-tn@semihalf.com>
 <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
 <e5b1f09c-ca4c-fbf0-e9d7-c943ad0df2ff@redhat.com>
Message-ID: <CADaLNDm8Zp_kAqVvSd0po9S3j2rSXxtUJ1M33dW7gLZzvueweQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 1, 2016 at 9:50 PM, Jon Masters <jcm@redhat.com> wrote:
> On 11/30/2016 07:28 PM, Bjorn Helgaas wrote:
>
>> I'm hoping to end up with something like this:
>> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ecam&id=51ad4df79a9b7f2a66b346a46b21a785a2937469
>
> The following build warnings happen using your branch on RHELSA7.3:
>
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
>   THUNDER_PEM_QUIRK(2,  0), /* off-chip devices */
>   ^
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[44].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[44].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[45].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[45].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[46].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[46].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[47].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[47].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[48].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[48].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[49].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[49].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
>   THUNDER_PEM_QUIRK(2,  1), /* off-chip devices */
>   ^
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[50].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[50].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[51].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[51].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[52].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[52].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[53].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[53].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[54].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[54].cfgres.end?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[55].cfgres.start?) [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
> drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[55].cfgres.end?) [enabled by default]

I saw this too. It can be fixed by changes below:

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 7319188..3d7c5cc 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -98,16 +98,16 @@ struct mcfg_fixup {
        { "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,                 \
        &pci_thunder_ecam_ops }
        /* SoC pass1.x */
-   THUNDER_PEM_QUIRK(2,  0),       /* off-chip devices */
-   THUNDER_PEM_QUIRK(2,  1),       /* off-chip devices */
-   THUNDER_ECAM_QUIRK(2,  0),
-   THUNDER_ECAM_QUIRK(2,  1),
-   THUNDER_ECAM_QUIRK(2,  2),
-   THUNDER_ECAM_QUIRK(2,  3),
-   THUNDER_ECAM_QUIRK(2, 10),
-   THUNDER_ECAM_QUIRK(2, 11),
-   THUNDER_ECAM_QUIRK(2, 12),
-   THUNDER_ECAM_QUIRK(2, 13),
+ THUNDER_PEM_QUIRK(2, 0UL),  /* off-chip devices */
+ THUNDER_PEM_QUIRK(2, 1UL),  /* off-chip devices */
+ THUNDER_ECAM_QUIRK(2, 0UL),
+ THUNDER_ECAM_QUIRK(2, 1UL),
+ THUNDER_ECAM_QUIRK(2, 2UL),
+ THUNDER_ECAM_QUIRK(2, 3UL),
+ THUNDER_ECAM_QUIRK(2, 10UL),
+ THUNDER_ECAM_QUIRK(2, 11UL),
+ THUNDER_ECAM_QUIRK(2, 12UL),
+ THUNDER_ECAM_QUIRK(2, 13UL),

 #define XGENE_V1_ECAM_MCFG(rev, seg) \
        {"APM   ", "XGENE   ", rev, seg, MCFG_BUS_ANY, \

>
> Jon.
>
> --
> Computer Architect | Sent from my Fedora powered laptop
> _______________________________________________
> Linaro-acpi mailing list
> Linaro-acpi at lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/linaro-acpi
Regards,
Duc Dang.
