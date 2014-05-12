From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Mon, 12 May 2014 20:43:59 +0300
Subject: [PATCHv5 07/20] usb: host: xhci-plat: add clock support
In-Reply-To: <5370DEC7.9080708@free-electrons.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399832288-19899-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <5370DEC7.9080708@free-electrons.com>
Message-ID: <5371085F.2010400@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2014 05:46 PM, Gregory CLEMENT wrote:
> Hi Mathias, Felipe,
>
> On 11/05/2014 20:17, Thomas Petazzoni wrote:
>> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> Some platforms (such as the Armada 38x ones) can gate the clock of
>> their USB controller. This patch adds the support for one clock in
>> xhci-plat, by enabling it during probe and disabling it on remove.
>>
>> To achieve this, it adds a 'struct clk *' member in xhci_hcd. While
>> only used for now in xhci-plat, it might be used by other drivers in
>> the future. Moreover, the xhci_hcd structure already holds other
>> members such as msix_count and msix_entries, which are MSI-X specific,
>> and therefore only used by xhci-pci.
>
> Felpie,
>
> would you agree to add your acked-by on this patch. You gave it on
> the 3rd version however as pointed by Thomas there was some issues,
> what do you think of this version?
>
>
> Mathias,
>
> as the xHCI maintainer what is your opinion on this patch. Do you plan
> to take it? do you expect a pull request?
>
> We submitted the first version of this series one month ago and we didn't
> receive any feedback from you. Maybe it was just because you were happy
> with the patch sent, but I would like to be sure that you noticed this
> series.
>
> I have the same question for the patch before: "[PATCHv5 06/20] usb: host:
> xhci-plat: sort the headers in alphabetic order" and the three following:
> "[PATCHv5 07/20] usb: host: xhci-plat: add clock support", "[PATCHv5 08/20]
>   usb: host: xhci-plat: add support for the Armada 375/38x XHCI controllers"
> and "[PATCHv5 09/20] Documentation: dt-bindings: update xhci-platform DT
> binding".
>

Hi

Sorry about the delay, Only thing I found was a sparse warning, otherwise looks ok.

-Mathias
