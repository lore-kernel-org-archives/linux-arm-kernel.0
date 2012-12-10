From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Dec 2012 13:08:08 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121210195935.1b8a7797@skate>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com> <50C62161.9080708@wwwdotorg.org>
 <20121210190552.74acbe5a@skate> <50C626E4.1010808@wwwdotorg.org>
 <20121210195935.1b8a7797@skate>
Message-ID: <50C64128.3030104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2012 11:59 AM, Thomas Petazzoni wrote:
...
> Well, I am not a PCI or PCIe expert, so my terminology might be wrong.
> Basically, on Armada XP, you have:
> 
>  PCIe 0.0 (can be x4, in which case PCIe 0.{1,2,3} can't be used, or x1)
>  PCIe 0.1 x1
...
> And the address decoding windows are associated to a PCIe interface
> (through its x.y number). So for now, there is a one-to-one mapping
> between a PCIe interface and a PCIe device, and therefore with an
> address decoding window.
> 
> That said, I suppose that what you're thinking of are PCIe bridges, is

Yes, I was definitely thinking of the device that's plugged into a PCIe
port being a bridge itself, with multiple downstream devices.

> that correct? So those would allow to connect multiple PCIe devices on
> a single PCIe interface (for example PCIe 3.0 listed above). In that
> case, I suppose my address decoding window would have to have a size
> greater than or equal to the sum of the size of all BARs of the PCIe
> devices found on the downstream bus. Lior, could you confirm or infirm
> my statement?

That sounds about right.

> Does that answer your question?

Yes, thanks.
