From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 25 Jul 2017 15:56:20 +0000
Subject: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
In-Reply-To: <a61222c6-e548-1e3b-f6f7-63952b90ac13@redhat.com>
References: <20170719012839.20124-1-dja@axtens.net>
 <CAKv+Gu-SgeLXVEj_VtZHchaNmOwWO+GmfTg5CYcnOF43AJZGnA@mail.gmail.com>
 <87pocusm2x.fsf@linkitivity.dja.id.au>
 <CAKv+Gu-O7cyJSgDrqSNi6F_n9eBnFEgz==aqowMqhy+81YK=CQ@mail.gmail.com>
 <87r2x6vj7t.fsf@linkitivity.dja.id.au>
 <a61222c6-e548-1e3b-f6f7-63952b90ac13@redhat.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B76A1A@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laszlo

[...]

> 
> Having practically zero background in gfx development (either kernel or
> Xorg), I think the problem is that vga_default_device() /
> vga_set_default_device(), which -- apparently -- "boot_vga" is based
> upon, come from "drivers/gpu/vga/vgaarb.c". Namely, the concept of
> "primary / boot display device" is tied to the VGA arbiter, plus only a
> PCI device can currently be marked as primary/boot display device.
> 
> Can these concepts be split from each other? (I can fully imagine that
> this would result in a userspace visible interface change (or
> addition),
> so that e.g. "/sys/devices/**/boot_gpu" would have to be consulted by
> display servers.)
> 
> (Sorry if I'm totally wrong.)
> 
> ... Hm, reading the thread starter at
> <https://www.mail-archive.com/linuxppc-
> dev at lists.ozlabs.org/msg120851.html>,
> and the references within... It looks like this work is motivated by
> hardware that is supposed to be PCI, but actually breaks the specs. Is
> that correct? If so, then I don't think I can suggest anything useful.

My understanding is that the current PCIe HW is specs compliant but the
vgaarb, in order to make a VGA device the default one, requires all the
bridges on top of such device to have the "VGA Enable" bit set (optional
bit in the PCI Express? to PCI/PCI-X Bridge Spec). I.e. all the bridges
on top have to support legacy VGA devices; and this is not mandatory
from the specs...right?

BTW my VGA experience is limited too...this is just my understanding...

Gab

> Specs exist so that hardware vendors and software authors follow them.
> If hardware does not conform, then software should either refuse to
> work
> with it, or handle it with quirks, on a case-by-case basis. I guess
> this
> means that I don't agree with the
> 
>   broad[] suggest[ion] that a more generic solution would be better
> 
> which seems to disqualify me from the discussion, as it must have been
> suggested by people with incomparably more experience than what I have
> :)
> 
> Thanks
> Laszlo
