From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Apr 2014 17:40:34 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408171309.09bbf968@skate>
References: <20140325202249.GA10378@obsidianresearch.com>
 <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate>
Message-ID: <20140408174034.79df403e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

On Tue, 8 Apr 2014 17:13:09 +0200, Thomas Petazzoni wrote:

> Unfortunately here your patch is not sufficient to solve the problem
> apparently. I've fixed another problem where the return value of
> armada_370_xp_alloc_msi() (which is signed) is casted into an unsigned
> irq_hw_number_t in armada_370_xp_setup_msi_irq(), but I'm still seeing
> many MSIs allocated, then some freed, and finally a kernel panic.
> 
>  * Log: https://gist.github.com/tpetazzoni/10140012
> 
>  * Diff against v3.14: https://gist.github.com/tpetazzoni/10140121
> 
> Ideas? If some of you are interested in discussing this live, I'm on
> #mvlinux on Freenode.

Please find attached the 3 patches I'm currently using on the
irq-armada-370-xp. They make the situation a bit better (the igb driver
no longer believes we support MSI-X), but it still crashes in the igb
driver (see https://gist.github.com/tpetazzoni/10144886).

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-irqchip-armada-370-xp-fix-invalid-cast-of-signed-val.patch
Type: text/x-patch
Size: 1375 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140408/eff616ce/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-irqchip-armada-370-xp-implement-the-check_device-msi.patch
Type: text/x-patch
Size: 1698 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140408/eff616ce/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-irqchip-armada-370-xp-Fix-releasing-of-MSIs.patch
Type: text/x-patch
Size: 1271 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140408/eff616ce/attachment-0002.bin>
