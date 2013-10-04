From: matthew_minter@xyratex.com (Matthew Minter)
Date: Fri, 4 Oct 2013 15:58:21 +0100
Subject: Arm PCIe hotplugging
In-Reply-To: <20131004162205.7a6f516f@skate>
References: <CAFJTrDs=fovP8nWVvH=-a9d_OTbmgQkMLPVeKAc4x6phsuZw9w@mail.gmail.com>
 <20131004135345.GA31178@titan.lakedaemon.net>
 <20131004162205.7a6f516f@skate>
Message-ID: <CAFJTrDvwT+bqwFOQdzYLr3rEZU3unev2WOv8v_vPHbOQom3gsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the responses guys both on the advice on ccing others. It
is good to know someone else has managed to get it working.

For now, in case it saves time later here is the output of my lspci -t::

-[0000:00]-+-01.0-[01]--
           +-09.0-[02-08]----00.0-[03-08]--+-01.0-[04]--
           |                               +-02.0-[05]----00.0
           |                               +-0a.0-[06]--
           |                               +-0c.0-[07]--
           |                               \-0e.0-[08]--
           \-0a.0-[09]--

and my lspci -vvk:

00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if
00 [Normal decode])
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    Prefetchable memory behind bridge: 00000000-000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
        PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+

00:09.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if
00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=02, subordinate=08, sec-latency=0
    I/O behind bridge: 00010000-00011fff
    Memory behind bridge: e0000000-e06fffff
    Prefetchable memory behind bridge: 00000000-000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
        PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+

00:0a.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (prog-if
00 [Normal decode])
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
    Prefetchable memory behind bridge: 00000000-000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort+ >Reset+ FastB2B+
        PriDiscTmr+ SecDiscTmr+ DiscTmrStat+ DiscTmrSERREn+

02:00.0 PCI bridge: PLX Technology, Inc. PEX 8614 12-lane, 12-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Region 0: Memory@e0600000 (32-bit, non-prefetchable) [size=128K]
    Bus: primary=02, secondary=03, subordinate=08, sec-latency=0
    I/O behind bridge: 00010000-00011fff
    Memory behind bridge: e0000000-e02fffff
    Prefetchable memory behind bridge: 00000000e0300000-00000000e05fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Address: 00000000d0020a04  Data: 0f10
        Masking: 00000001  Pending: 00000000
    Capabilities: [68] Express (v2) Upstream Port, MSI 00
        DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-SlotPowerLimit 0.000W
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
        LnkCap:    Port #0, Speed 5GT/s, Width x4, ASPM L0s L1,
Latency L0 <1us, L1 <2us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 5GT/s, Width x4, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8614
12-lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
    Capabilities: [100 v1] Device Serial Number ba-86-01-10-b5-df-0e-00
    Capabilities: [fb4 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr+ BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [138 v1] Power Budgeting <?>
    Capabilities: [148 v1] Virtual Channel
        Caps:    LPEVC=1 RefClk=100ns PATEntryBits=4
        Arb:    Fixed+ WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=06 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32+ WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=WRR32 TC/VC=ff
            Status:    NegoPending- InProgress-
            Port Arbitration Table <?>
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
            Status:    NegoPending+ InProgress-
    Capabilities: [448 v1] Vendor Specific Information: ID=0000 Rev=0
Len=0cc <?>
    Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
    Kernel driver in use: pcieport

03:01.0 PCI bridge: PLX Technology, Inc. PEX 8614 12-lane, 12-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=03, secondary=04, subordinate=04, sec-latency=0
    I/O behind bridge: 00010000-00010fff
    Memory behind bridge: e0000000-e01fffff
    Prefetchable memory behind bridge: 00000000e0300000-00000000e04fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Address: 00000000d0020a04  Data: 0f11
        Masking: 00000001  Pending: 00000000
    Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
        DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x4, ASPM L0s L1,
Latency L0 <2us, L1 <4us
            ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surprise-
            Slot #1, PowerLimit 25.000W; Interlock+ NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Off, PwrInd On, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8614
12-lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
    Capabilities: [100 v1] Device Serial Number ba-86-01-10-b5-df-0e-00
    Capabilities: [fb4 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [148 v1] Virtual Channel
        Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
        Arb:    Fixed+ WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending+ InProgress-
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
            Status:    NegoPending+ InProgress-
    Capabilities: [520 v1] Access Control Services
        ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl+ DirectTrans+
        ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
    Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
    Kernel driver in use: pcieport

03:02.0 PCI bridge: PLX Technology, Inc. PEX 8614 12-lane, 12-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=03, secondary=05, subordinate=05, sec-latency=0
    I/O behind bridge: 00011000-00011fff
    Memory behind bridge: e0200000-e02fffff
    Prefetchable memory behind bridge: 00000000e0500000-00000000e05fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Address: 00000000d0020a04  Data: 0f12
        Masking: 00000001  Pending: 00000000
    Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
        DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
        LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1,
Latency L0 <1us, L1 <2us
            ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 5GT/s, Width x1, TrErr- Train- SlotClk-
DLActive+ BWMgmt- ABWMgmt+
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #2, PowerLimit 25.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Off, PwrInd Off, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet+ LinkState+
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8614
12-lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
    Capabilities: [100 v1] Device Serial Number ba-86-01-10-b5-df-0e-00
    Capabilities: [fb4 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [148 v1] Virtual Channel
        Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
        Arb:    Fixed+ WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
            Status:    NegoPending+ InProgress-
    Capabilities: [520 v1] Access Control Services
        ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl+ DirectTrans+
        ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
    Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
    Kernel driver in use: pcieport

03:0a.0 PCI bridge: PLX Technology, Inc. PEX 8614 12-lane, 12-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=03, secondary=06, subordinate=06, sec-latency=0
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Address: 00000000d0020a04  Data: 0f13
        Masking: 00000001  Pending: 00000000
    Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
        DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
        LnkCap:    Port #10, Speed 5GT/s, Width x1, ASPM L0s L1,
Latency L0 <2us, L1 <4us
            ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #10, PowerLimit 25.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Off, PwrInd Off, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8614
12-lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
    Capabilities: [100 v1] Device Serial Number ba-86-01-10-b5-df-0e-00
    Capabilities: [fb4 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [148 v1] Virtual Channel
        Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
        Arb:    Fixed+ WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending+ InProgress-
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
            Status:    NegoPending+ InProgress-
    Capabilities: [520 v1] Access Control Services
        ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl+ DirectTrans+
        ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
    Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
    Kernel driver in use: pcieport

03:0c.0 PCI bridge: PLX Technology, Inc. PEX 8614 12-lane, 12-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=03, secondary=07, subordinate=07, sec-latency=0
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Address: 00000000d0020a04  Data: 0f14
        Masking: 00000001  Pending: 00000000
    Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
        DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
        LnkCap:    Port #12, Speed 5GT/s, Width x1, ASPM L0s L1,
Latency L0 <2us, L1 <4us
            ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #12, PowerLimit 25.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Off, PwrInd Off, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8614
12-lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
    Capabilities: [100 v1] Device Serial Number ba-86-01-10-b5-df-0e-00
    Capabilities: [fb4 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [148 v1] Virtual Channel
        Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
        Arb:    Fixed+ WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending+ InProgress-
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
            Status:    NegoPending+ InProgress-
    Capabilities: [520 v1] Access Control Services
        ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl+ DirectTrans+
        ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
    Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
    Kernel driver in use: pcieport

03:0e.0 PCI bridge: PLX Technology, Inc. PEX 8614 12-lane, 12-Port PCI
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=03, secondary=08, subordinate=08, sec-latency=0
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity+ SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
        Address: 00000000d0020a04  Data: 0f15
        Masking: 00000001  Pending: 00000000
    Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
        DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
        LnkCap:    Port #14, Speed 5GT/s, Width x1, ASPM L0s L1,
Latency L0 <2us, L1 <4us
            ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #14, PowerLimit 25.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Off, PwrInd Off, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8614
12-lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
    Capabilities: [100 v1] Device Serial Number ba-86-01-10-b5-df-0e-00
    Capabilities: [fb4 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 1f, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [148 v1] Virtual Channel
        Caps:    LPEVC=1 RefClk=100ns PATEntryBits=1
        Arb:    Fixed+ WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending+ InProgress-
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable- ID=1 ArbSelect=Fixed TC/VC=00
            Status:    NegoPending+ InProgress-
    Capabilities: [520 v1] Access Control Services
        ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl+ DirectTrans+
        ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
    Capabilities: [950 v1] Vendor Specific Information: ID=0001 Rev=0
Len=010 <?>
    Kernel driver in use: pcieport

05:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9230 PCIe
SATA 6Gb/s Controller (rev 10) (prog-if 01 [AHCI 1.0])
    Subsystem: ASUSTeK Computer Inc. Device 857a
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 122
    Region 0: I/O ports at 11020 [size=8]
    Region 1: I/O ports at 11030 [size=4]
    Region 2: I/O ports at 11028 [size=8]
    Region 3: I/O ports at 11034 [size=4]
    Region 4: I/O ports at 11000 [size=32]
    Region 5: Memory at e0200000 (32-bit, non-prefetchable) [size=2K]
    Expansion ROM at e0500000 [disabled] [size=64K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: d0020a04  Data: 0f16
    Capabilities: [70] Express (v2) Legacy Endpoint, MSI 00
        DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <8us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
        LnkCap:    Port #0, Speed 5GT/s, Width x2, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-,
OBFF Not Supported
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [e0] SATA HBA v0.0 BAR4 Offset=00000004
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
    Kernel driver in use: ahci

On 4 October 2013 15:22, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Jason Cooper,
>
> On Fri, 4 Oct 2013 09:53:45 -0400, Jason Cooper wrote:
>
>> Please Cc: the relevant maintainers, it helps us pick out emails needing
>> our attention out of the noise ;-)  I've added them to this reply.
>
> True!
>
>> > I have been doing some work with an Armada XP board (DB-MV784MP-GP)
>> > with PCIe support, along with using a PEX 8614 (AA) PCIe switch. The
>> > switch in question is said to have hot plug support with the PCIe
>> > downstream slots.
>> >
>> > However using both the generic "pcieport" and the proprietary kernel
>> > module used by PLX (this took some work to run on an ARM board and is
>> > very buggy on the platform buggy so the generic in tree drivers are
>> > preferable) the /sys/bus/pci/slots/ directory is always empty and
>> > /sys/bus/pci/rescan seems to do nothing.
>> >
>> > Looking closer it seems that in the ARM kernel the PCI hotplug code is
>> > all disabled. Am I just out of luck and should wait until there is a
>> > new driver for the PCI switch's hot plug controller and a general hot
>> > plug framework for ARM or is there some kind of work around?
>
> I known Jason Gunthorpe has gotten hotplug to work on Kirkwood with the
> PCIe driver that is also used for Armada 370/XP (which in fact we
> originally wrote for 370/XP). I'll let him answer you, but I guess you
> would need to provide a few more details (lspci outputs, etc.).
>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
