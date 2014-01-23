From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 23 Jan 2014 09:24:41 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <20140122235620.GC20359@xanatos> (Sarah Sharp's message of "Wed,
 22 Jan 2014 15:56:20 -0800")
References: <87mwix5anm.fsf@natisbad.org> <20140116185044.GC18392@xanatos>
 <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos> <87vbxhrmea.fsf@natisbad.org>
 <20140121211741.GA12657@xanatos> <87bnz364h0.fsf@natisbad.org>
 <20140122222641.GD29184@titan.lakedaemon.net>
 <87mwin4ozf.fsf@natisbad.org> <20140122235620.GC20359@xanatos>
Message-ID: <87sisfjeba.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sarah,

Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:

>> > Can you pinpoint the commit that introduced the regression?
>> 
>> f5182b4155b9d686c5540a6822486400e34ddd98 "xhci: Disable MSI for some Fresco Logic hosts."
>> 
>> Technically, this is not per se the commit which introduced the
>> regression but the one that *partially* fixed it by introducing the XHCI
>> quirk to skip MSI enabling for Fresco Logic chips. The thing is it
>> should have included the FL1009 in the targets. Sarah, can you confirm
>> this?
>
> I don't know if it should have included FL1009, it was just a guess,
> based on the fact that the 0x1000 and 0x1400 devices did need MSI
> disabled.  I can attempt to ask the Fresco Logic folks I know, but I'm
> not sure if/when I'll get a response back.
>
> That still doesn't necessarily rule out MSI issues in the Marvell PCI
> host controller code.  Can you attach another PCI device with MSI
> support under the host and see if it works?

The various Armada-based devices I have are NAS which do not have PCIe
slots to plug additional devices (everything is soldered). I don't know
which device Thomas used for its tests. Just in case, I also added Willy
in CC: who have various boards and may also have done more test with
additional PCIe devices and CONFIG_PCI_MSI enabled on 3.13 kernel.

Cheers,

a+
