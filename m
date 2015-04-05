From: bhelgaas@google.com (Bjorn Helgaas)
Date: Sat, 4 Apr 2015 22:25:03 -0500
Subject: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
In-Reply-To: <CAL_JsqJyH==8OtkcU8_P4_47U6qe6FYqj-WUZ20_Y+iC_OF4_w@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org>
 <20150403193234.GD10892@google.com>
 <20150403205201.GF10892@google.com>
 <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
 <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com>
 <CAL_JsqJyH==8OtkcU8_P4_47U6qe6FYqj-WUZ20_Y+iC_OF4_w@mail.gmail.com>
Message-ID: <CAErSpo4cw2MSPmrur_QFMwnH01qf0XMfBEAyZ2f+HrUOGEXyjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 4, 2015 at 2:48 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Sat, Apr 4, 2015 at 7:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>> I think there's still an unresolved question about the OF parsing code.
>
> Got a pointer to what that is? I'll take a guess. Generally, we make
> the parsing code independent of the kernel addr sizes and use u64
> types. The DT sizes and kernel sizes are not always aligned. For
> example, an LPAE capable platform running a non-LPAE kernel build.

Yep: http://lkml.kernel.org/r/1427857069-6789-3-git-send-email-yinghai at kernel.org

Yinghai made a change to the sparc OF parsing code.  The question is
whether a similar change should be made to clones of that code (two
others in arch/sparc, one in arch/powerpc, and one in drivers/of).

Bjorn
