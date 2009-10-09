From: alex@digriz.org.uk (Alexander Clouter)
Date: Fri, 9 Oct 2009 16:24:07 +0100
Subject: [PATCH] [ARM] kirkwood: combine support for openrd base/client
	support
In-Reply-To: <200910091600.45161.dk-arm-linux@gmx.de>
References: <20091009123956.GA6085@chipmunk>
	<200910091600.45161.dk-arm-linux@gmx.de>
Message-ID: <20091009152407.GE6085@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Dieter Kiermaier <dk-arm-linux@gmx.de> [2009-10-09 16:00:44+0200]:
>
> [snipped]
>
> Additionally it would be nice, if you could integrate the i2c / pcie init in your patch?
> Please see Simons patch at:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/001950.html
> 
Well on my Client board I get:
----
northdown:~# dmesg | grep -i PCI                                                                                                 
pci 0000:00:00.0: reg 10 64bit mmio pref: [0xf1000000-0xf10fffff]
pci 0000:00:00.0: reg 18 32bit mmio: [0x000000-0x1fffffff]
pci 0000:00:00.0: supports D1 D2
PCI: bus0: Fast back to back transfers disabled

northdown:~# lspci -vvv
00:00.0 Memory controller: Marvell Technology Group Ltd. Device 6281 (rev 02)
        Subsystem: Marvell Technology Group Ltd. Device 11ab
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory@<ignored> (64-bit, prefetchable)
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] Express (v1) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <256ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 unlimited
                        ClockPM+ Suprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [100] Advanced Error Reporting <?>
----

I guess it is working fine, however as there is no PCI(e) slot to use, 
I'm going to disable the call for the OpenRD Client as it's pointless; 
unless someone objects?

Cheers

-- 
Alexander Clouter
.sigmonster says: Dyslexia means never having to say that you're ysror.
