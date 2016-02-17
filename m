From: jayachandran.chandrashekaran@broadcom.com (Jayachandran Chandrashekaran Nair)
Date: Wed, 17 Feb 2016 19:14:13 +0530
Subject: [PATCH V5 07/15] pci, acpi: Provide generic way to assign bus
 domain number.
In-Reply-To: <1455630825-27253-8-git-send-email-tn@semihalf.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-8-git-send-email-tn@semihalf.com>
Message-ID: <CAKc_7PU+i2AwOVCyW2VNt4BZCWw=KBMAbV8v9DVQ2Ess3WE=kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz, Lorenzo,

On Tue, Feb 16, 2016 at 7:23 PM, Tomasz Nowicki <tn@semihalf.com> wrote:
> As we now have valid PCI host bridge device reference we can
> introduce code that is going to find its bus domain number using
> ACPI _SEG method.
>
> Note that _SEG method is optional, therefore _SEG absence means
> that all PCI buses belong to domain 0.
>
> While at it, for the sake of code clarity we put ACPI and DT domain
> assign methods into the corresponding helpers.

In my patchset, I had a slightly different and I think better approach for
this without calling the _SEG method again. Please see
http://www.spinics.net/lists/arm-kernel/msg478167.html
at the last part of http://www.spinics.net/lists/arm-kernel/msg478169.html

JC.
