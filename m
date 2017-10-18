From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 18 Oct 2017 10:07:16 +0100
Subject: [PATCH v4 pci 0/2] PCI/MSI: pci-xgene-msi: Enable MSI support in
 ACPI boot for X-Gene v1
In-Reply-To: <CAAsHzqsxMy8On5ThggTwYohqMCLEJTbA=b1LgUPiuKu9C+eHeQ@mail.gmail.com>
References: <1506448161-30961-1-git-send-email-kdinh@apm.com>
 <CAAsHzqv-oQVNm-pNP4Q1KmiSmjaiFx1S4j8uCnij53Te3h8KKg@mail.gmail.com>
 <20171017133807.GB948@red-moon>
 <CAAsHzqsxMy8On5ThggTwYohqMCLEJTbA=b1LgUPiuKu9C+eHeQ@mail.gmail.com>
Message-ID: <20171018090716.GA14820@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 10:45:35PM -0700, Khuong Dinh wrote:
> Hi Lorenzo,
>
> On Tue, Oct 17, 2017 at 6:38 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > Hi Khuong,
> >
> > On Mon, Oct 16, 2017 at 02:19:50PM -0700, Khuong Dinh wrote:
> >> Hi Lorenzo,
> >>   Do you have any comments for this patch?
> >
> > I'd have some comments but given that there are related issues with ACPI
> > probe ordering that Marc is trying to solve on his side - I will work
> > with him to see if we can accommodate changes that can solve this issue
> > too.
> >
> > Again - I recognize it is a complex problem (that is not even
> > contemplated by the current ACPI specs), we have to try to make
> > the solution as generic as we can to prevent reinventing the wheel
> > anytime a sligthly different issue (related to ACPI probe ordering)
> > comes up.
> >
> > Leave it to me (us) and I will get back to you on this.
>
> Thanks for helping to take care of the generic ACPI probe ordering issue.
> Given that the patch 'PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI
> boot for X-Gene v1" adds only the ACPI ID, can you pull in this patch
> independently from the ACPI probe ordering issue?

No. For two reasons:

1) It's Bjorn who decides whether that code can be merged or not, not
   me
2) That patch sneaks in ACPI MSI support for X-gene v1 that depends
   on kernel link ordering. As soon as it is pulled in the mainline
   it creates a dependency on pseudo-working code that may break
   anytime and as I said many times before I am not willing to rely
   on that.

Lorenzo
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
