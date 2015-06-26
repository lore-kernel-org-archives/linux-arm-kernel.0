From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 26 Jun 2015 09:26:21 -0500
Subject: [PATCH 1/1] pci: xgene: Enable huge outbound bar support
In-Reply-To: <1435280756-24455-1-git-send-email-dhdang@apm.com>
References: <1435280756-24455-1-git-send-email-dhdang@apm.com>
Message-ID: <CAErSpo7rE8yAS--L+aQmN-DqfL6uGxFBxD2WOPowoBsrvOZ7eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Duc,

On Thu, Jun 25, 2015 at 8:05 PM, Duc Dang <dhdang@apm.com> wrote:
> X-Gene PCIe controllers support huge outbound BARs (with size upto
> 64GB). This patch configures additional 1 outbound BAR for X-Gene
> PCIe controllers with size larger than 4GB. This is required to
> support devices that request huge outbound memory (nVidia K40 as an
> example)

The PCI specs don't use the "outbound BAR" terminology.  I assume this
is what we normally call "windows" or "apertures" for MMIO access by
the CPU?  (The specs rarely use those terms either, but they're
commonly used in Linux, and the PCIe spec does mention them a couple
times.)

By "request huge outbound memory," I assume you simply mean the device
has a huge BAR, right?

Bjorn
