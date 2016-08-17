From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 18 Aug 2016 00:17:18 +0200 (CEST)
Subject: [PATCH V2 RFC 6/6] ARM: dts: bcm2835: Add Raspberry Pi Zero
In-Reply-To: <badc3aa5-29ac-9b8c-2531-564c44b60030@synopsys.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-7-git-send-email-stefan.wahren@i2se.com>
 <722dafcb-2f67-88c7-69df-d442c56c058f@synopsys.com>
 <263309088.290419.51598113-17aa-4db0-9dc0-6e58e3fafe07.open-xchange@email.1und1.de>
 <ac20c0e9-0cab-7e3f-4abf-75223538a816@synopsys.com>
 <1270178266.398560.152fe5dd-527b-4ad6-b2fd-e4b0af6bc2a9.open-xchange@email.1und1.de>
 <badc3aa5-29ac-9b8c-2531-564c44b60030@synopsys.com>
Message-ID: <85508461.401578.b150078c-11e6-4a32-b9b6-f40bf8417708.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

> John Youn <John.Youn@synopsys.com> hat am 17. August 2016 um 23:21
> geschrieben:
> 
> 
> ...
> Ok, yeah, that seems better.
> 
> Can you check if applying just patch 2 and 3 solves the issue? If so I
> think we can send those upstream.

unfortunately not:

[    2.280719] dwc2_lowlevel_hw_init()
[    2.288028] dwc2_set_all_params()
[    2.295162] dwc2_lowlevel_hw_enable()
[    2.302439] dwc2_get_dr_mode()
[    2.309043] dwc2_core_reset_and_force_dr_mode()
[    2.489040] dwc2_get_hwparams()
[    2.495629] dwc2 20980000.usb: Core Release: 2.80a (snpsid=4f54280a)
[    2.495645] dwc2 20980000.usb: hwcfg1=00000000
[    2.495657] dwc2 20980000.usb: hwcfg2=228ddd50
[    2.495668] dwc2 20980000.usb: hwcfg3=0ff000e8
[    2.495680] dwc2 20980000.usb: hwcfg4=1ff00020
[    2.495691] dwc2 20980000.usb: grxfsiz=00001000
[    2.495701] dwc2 20980000.usb: Forcing mode to host
[    2.539076] dwc2 20980000.usb: gnptxfsiz=00201000
[    2.539090] dwc2 20980000.usb: hptxfsiz=00000000
[    2.589054] dwc2 20980000.usb: gnptxfsiz=00201000
[    2.589071] dwc2 20980000.usb: Detected values from hardware:
[    2.589082] dwc2 20980000.usb:   op_mode=0
[    2.589093] dwc2 20980000.usb:   arch=2
[    2.589104] dwc2 20980000.usb:   dma_desc_enable=0
[    2.589115] dwc2 20980000.usb:   power_optimized=0
[    2.589125] dwc2 20980000.usb:   i2c_enable=0
[    2.589134] dwc2 20980000.usb:   hs_phy_type=1
[    2.589144] dwc2 20980000.usb:   fs_phy_type=1
[    2.589154] dwc2 20980000.usb:   utmi_phy_data_width=0
[    2.589164] dwc2 20980000.usb:   num_dev_ep=7
[    2.589174] dwc2 20980000.usb:   num_dev_perio_in_ep=0
[    2.589183] dwc2 20980000.usb:   host_channels=8
[    2.589195] dwc2 20980000.usb:   max_transfer_size=524287
[    2.589206] dwc2 20980000.usb:   max_packet_count=1023
[    2.589216] dwc2 20980000.usb:   nperio_tx_q_depth=0x4
[    2.589226] dwc2 20980000.usb:   host_perio_tx_q_depth=0x4
[    2.589236] dwc2 20980000.usb:   dev_token_q_depth=0x8
[    2.589247] dwc2 20980000.usb:   enable_dynamic_fifo=1
[    2.589257] dwc2 20980000.usb:   en_multiple_tx_fifo=1
[    2.589267] dwc2 20980000.usb:   total_fifo_size=4080
[    2.589277] dwc2 20980000.usb:   host_rx_fifo_size=4096
[    2.589287] dwc2 20980000.usb:   host_nperio_tx_fifo_size=32
[    2.589299] dwc2 20980000.usb:   host_perio_tx_fifo_size=0
[    2.589307] dwc2 20980000.usb:
[    2.589312] dwc2_set_parameters()
[    2.595921] dwc2 20980000.usb: dwc2_set_parameters()
[    2.595940] dwc2 20980000.usb: Setting dma_desc_fs_enable to 0
[    2.595968] dwc2 20980000.usb: Setting external_id_pin_ctl to 0
[    2.595980] dwc2 20980000.usb: Setting hibernation to 0
[    2.596003] dwc2 20980000.usb: 256 invalid for host_nperio_tx_fifo_size.
Check HW configuration.
[    2.611528] dwc2 20980000.usb: Setting host_nperio_tx_fifo_size to 32
[    2.611552] dwc2 20980000.usb: 512 invalid for host_perio_tx_fifo_size. Check
HW configuration.
[    2.627250] dwc2 20980000.usb: Setting host_perio_tx_fifo_size to 0
[    2.627256] dwc2_force_dr_mode()
[    2.749035] dwc2_gadget_init()
[    2.755610] dwc2 20980000.usb: Specified GNPTXFDEP=1024 > 32
[    2.764876] dwc2 20980000.usb: EPs: 8, dedicated fifos, 4080 entries in SPRAM
[    2.792911] dwc2 20980000.usb: bound driver zero
[    2.801042] dwc2_hcd_init()
[    2.807485] dwc2 20980000.usb: DWC OTG Controller
[    2.815716] dwc2 20980000.usb: new USB bus registered, assigned bus number 1
[    2.826265] dwc2 20980000.usb: irq 33, io mem 0x00000000

Regards
Stefan

> 
> Regards,
> John
