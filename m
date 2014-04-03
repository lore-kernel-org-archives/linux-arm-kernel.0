From: matthew_minter@xyratex.com (Matthew Minter)
Date: Thu, 3 Apr 2014 10:31:42 +0100
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
In-Reply-To: <20140401164110.GA26093@obsidianresearch.com>
References: <CAFJTrDt7OrtE4B52419F2KGbmXeLR9NEcgF6yMTMUBe5vdKwfg@mail.gmail.com>
 <20140326180634.4ac266b2@skate>
 <20140326171828.GA31887@obsidianresearch.com>
 <CAFJTrDvb7gcLkv8-HqbJSLEj7V2Zg=5+pXFR2r3AZxG7waT6WA@mail.gmail.com>
 <20140401164110.GA26093@obsidianresearch.com>
Message-ID: <CAFJTrDsXT2WQchquDPQHbkypLoSFPB2qc9wYh12NjBK7eJ+QSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, I just realized I missed the lspci results in my last email.
They are as follows:

Before the oops:

00:01.0 Class 0604: Device 11ab:7826 (rev 02)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=05, sec-latency=0
        I/O behind bridge: 00010000-00013fff
        Memory behind bridge: e0000000-e0cfffff
        Prefetchable memory behind bridge: 00000000-000fffff

01:00.0 Class 0604: Device 10b5:8617 (rev ba)
        Flags: bus master, fast devsel, latency 0
        Memory at e0c00000 (32-bit, non-prefetchable) [size=128K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
        I/O behind bridge: 00010000-00013fff
        Memory behind bridge: e0000000-e05fffff
        Prefetchable memory behind bridge: 00000000e0600000-00000000e0bfffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Upstream Port, MSI 00
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [138] Power Budgeting <?>
        Capabilities: [148] Virtual Channel
        Capabilities: [448] Vendor Specific Information: ID=0000 Rev=0
Len=0cc <?>
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

02:01.0 Class 0604: Device 10b5:8617 (rev ba)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00010000-00010fff
        Memory behind bridge: e0000000-e01fffff
        Prefetchable memory behind bridge: 00000000e0600000-00000000e07fffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Downstream Port (Slot+), MSI 00
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Access Control Services
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

02:02.0 Class 0604: Device 10b5:8617 (rev ba)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 00011000-00011fff
        Memory behind bridge: e0200000-e03fffff
        Prefetchable memory behind bridge: 00000000e0800000-00000000e09fffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Downstream Port (Slot+), MSI 00
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Access Control Services
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

02:03.0 Class 0604: Device 10b5:8617 (rev ba)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: 00012000-00012fff
        Memory behind bridge: e0400000-e05fffff
        Prefetchable memory behind bridge: 00000000e0a00000-00000000e0bfffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Downstream Port (Slot+), MSI 00
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Access Control Services
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

After the oops:

00:01.0 Class 0604: Device 11ab:7826 (rev 02)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=05, sec-latency=0
        I/O behind bridge: 00010000-00013fff
        Memory behind bridge: e0000000-e0cfffff
        Prefetchable memory behind bridge: 00000000-000fffff

01:00.0 Class 0604: Device 10b5:8617 (rev ba)
        Flags: bus master, fast devsel, latency 0
        Memory at e0c00000 (32-bit, non-prefetchable) [size=128K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
        I/O behind bridge: 00010000-00013fff
        Memory behind bridge: e0000000-e05fffff
        Prefetchable memory behind bridge: 00000000e0600000-00000000e0bfffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Upstream Port, MSI 00
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [138] Power Budgeting <?>
        Capabilities: [148] Virtual Channel
        Capabilities: [448] Vendor Specific Information: ID=0000 Rev=0
Len=0cc <?>
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

02:01.0 Class 0604: Device 10b5:8617 (rev ba)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00010000-00010fff
        Memory behind bridge: e0000000-e01fffff
        Prefetchable memory behind bridge: 00000000e0600000-00000000e07fffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Downstream Port (Slot+), MSI 00
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Access Control Services
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

02:02.0 Class 0604: Device 10b5:8617 (rev ba)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 00011000-00011fff
        Memory behind bridge: e0200000-e03fffff
        Prefetchable memory behind bridge: 00000000e0800000-00000000e09fffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Downstream Port (Slot+), MSI 00
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Access Control Services
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

02:03.0 Class 0604: Device 10b5:8617 (rev ba)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: 00012000-00012fff
        Memory behind bridge: e0400000-e05fffff
        Prefetchable memory behind bridge: 00000000e0a00000-00000000e0bfffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
        Capabilities: [68] Express Downstream Port (Slot+), MSI 00
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Access Control Services
        Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
        Kernel driver in use: pcieport

04:00.0 Class 0106: Device 144d:a800 (rev 01) (prog-if 01)
        Subsystem: Device 144d:a811
        Flags: fast devsel, IRQ 255
        Memory at e0200000 (32-bit, non-prefetchable) [size=8K]
        [virtual] Expansion ROM at e0800000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/2 Maskable+ 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [d0] Vital Product Data
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [150] Power Budgeting <?>
        Capabilities: [160] Latency Tolerance Reporting
        Kernel driver in use: ahci


Finally just in case it helps vv:

00:01.0 Class 0604: Device 11ab:7826 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=05, sec-latency=0
        I/O behind bridge: 00010000-00013fff
        Memory behind bridge: e0000000-e0cfffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

01:00.0 Class 0604: Device 10b5:8617 (rev ba)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Region 0: Memory@e0c00000 (32-bit, non-prefetchable) [size=128K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
        I/O behind bridge: 00010000-00013fff
        Memory behind bridge: e0000000-e05fffff
        Prefetchable memory behind bridge: 00000000e0600000-00000000e0bfffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [68] Express (v2) Upstream Port, MSI 00
                DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency
L0s <64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
FLReset-SlotPowerLimit 0.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1,
Latency L0 <2us, L1 <4us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train-
SlotClk- DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100 v1] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [138 v1] Power Budgeting <?>
        Capabilities: [148 v1] Virtual Channel
                Caps:   LPEVC=1 RefClk=100ns PATEntryBits=4
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=06 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32+ WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=WRR32 TC/VC=ff
                        Status: NegoPending- InProgress-
                        Port Arbitration Table <?>
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=1 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending+ InProgress-
        Capabilities: [448 v1] Vendor Specific Information: ID=0000
Rev=0 Len=0cc <?>
        Capabilities: [950 v1] Vendor Specific Information: ID=0001
Rev=0 Len=010 <?>
        Kernel driver in use: pcieport

02:01.0 Class 0604: Device 10b5:8617 (rev ba)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00010000-00010fff
        Memory behind bridge: e0000000-e01fffff
        Prefetchable memory behind bridge: 00000000e0600000-00000000e07fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
                DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency
L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x4, ASPM L0s L1,
Latency L0 <2us, L1 <4us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train-
SlotClk- DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #1, PowerLimit 25.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100 v1] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [148 v1] Virtual Channel
                Caps:   LPEVC=1 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending+ InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=1 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending+ InProgress-
        Capabilities: [520 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl+ DirectTrans+
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
        Capabilities: [950 v1] Vendor Specific Information: ID=0001
Rev=0 Len=010 <?>
        Kernel driver in use: pcieport

02:02.0 Class 0604: Device 10b5:8617 (rev ba)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 00011000-00011fff
        Memory behind bridge: e0200000-e03fffff
        Prefetchable memory behind bridge: 00000000e0800000-00000000e09fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
                DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency
L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #2, Speed 2.5GT/s, Width x4, ASPM L0s L1,
Latency L0 <2us, L1 <4us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x2, TrErr- Train-
SlotClk- DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #2, PowerLimit 25.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState+
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100 v1] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [148 v1] Virtual Channel
                Caps:   LPEVC=1 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=1 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending+ InProgress-
        Capabilities: [520 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl+ DirectTrans+
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
        Capabilities: [950 v1] Vendor Specific Information: ID=0001
Rev=0 Len=010 <?>
        Kernel driver in use: pcieport

02:03.0 Class 0604: Device 10b5:8617 (rev ba)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: 00012000-00012fff
        Memory behind bridge: e0400000-e05fffff
        Prefetchable memory behind bridge: 00000000e0a00000-00000000e0bfffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable- Count=1/4 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
                DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency
L0s <64ns, L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #3, Speed 2.5GT/s, Width x4, ASPM L0s L1,
Latency L0 <2us, L1 <4us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train-
SlotClk- DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #3, PowerLimit 25.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Off, PwrInd Off, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [a4] Subsystem: Device 10b5:8617
        Capabilities: [100 v1] Device Serial Number ba-86-01-10-b5-df-0e-00
        Capabilities: [fb4 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- Bahci 0000:04:00.0: vpd r/w
failed.  This is likely a firmware bug on this device.  Contact the
card vendor for a firmware update.
adDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [148 v1] Virtual Channel
                Caps:   LPEVC=1 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending+ InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=1 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending+ InProgress-
        Capabilities: [520 v1] Access Control Services
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl+ DirectTrans+
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
        Capabilities: [950 v1] Vendor Specific Information: ID=0001
Rev=0 Len=010 <?>
        Kernel driver in use: pcieport

04:00.0 Class 0106: Device 144d:a800 (rev 01) (prog-if 01)
        Subsystem: Device 144d:a811
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 255
        Region 5: Memory at e0200000 (32-bit, non-prefetchable) [size=8K]
        [virtual] Expansion ROM@e0800000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/2 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x4, ASPM L0s L1,
Latency L0 <4us, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x2, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis+, LTR+, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
                Not readable
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [150 v1] Power Budgeting <?>
        Capabilities: [160 v1] Latency Tolerance Reporting
                Max snoop latency: 256ns
                Max no snoop latency: 256ns
        Kernel driver in use: ahci


On 1 April 2014 17:41, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Mar 31, 2014 at 03:17:24PM +0100, Matthew Minter wrote:
>> Just to give an update of what I have tried. I noticed that there was
>> a PCI quirk available for a similar PLX chip which forced the kernel
>> to see the slots as hot-plug slots (unfortunately some PLX chips
>> falsely report themselves to be non hotplug capable bridges from my
>> understanding). I tried extending this quirk to run on my chip also.
>> This significantly changed the results in that along with the use of
>> pci=hpmemsize=xM I managed to force the chip to pre-allocate some
>> memory for the hotplug slot. Specifically I added this line:
>> DECLARE_PCI_FIXUP_HEADER(0x10b5, 0x8617, quirk_hotplug_bridge);
>> to linux-3.14-rc7/drivers/pci/quirks.c
>
> This all sounds right to me, it is probably the proper approach,
> things could be refined a bit by adding a DT property to indicate hot
> plug, but that won't help your oops.
>
> The oops kinda looks like something went wrong during a PCI memory
> read.
>
>> Internal error: : 1008 [#1] PREEMPT SMP ARM
>
> Which is a call to die, but the string that should tell us where is ""
> There are cases like that in the kernel, but all are prefixed by
> another line - did a line go missing (Unhandled Fault perhaps?)
>
> First guess would be something went wrong when the mbus windows were
> created after the rescan. Some debugging prints from that part of the
> flow might be informative, as well as a dump from the mbus debugfs..
>
> Second guess, something went wrong during the hot plug, and the PLX is
> not forwarding TLPs.. lpsci -v might give a clue.
>
>> I am currently working on a way to modify the scan order as Jason as
>> suggested, as soon as I have worked out exactly how the scan order is
>> determined I will try modifying the DT or any code needed to force the
>> port with the PLX chip to be scanned last. However I first need to
>> read some more of the code to understand what it orders on, eg: order
>> in DT, bus number, memory address.
>
> That suggestion was a hack, you have found the 'proper' way to do hot
> plug. If you can resolve this oops you should be golden :)
>
> Jason

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
