From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Thu, 18 Feb 2016 17:31:01 +0530
Subject: Query on using nvmem consumer API
Message-ID: <20160218120100.GA11366@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Srinivas,

I have a device tree node as follows

                        ocotp: ocotp at 400a5000 {
                                compatible = "fsl,vf610-ocotp";
                                #address-cells = <1>;
                                #size-cells = <1>;
                                reg = <0x400a5000 0xCF0>;
                                clocks = <&clks VF610_CLK_OCOTP>;

                                ocotp_cfg: cfg at 410 {
                                        reg = <0x410 0x20>;
                                };
                        };

and a nvmem data consumer node as follows

        soc-bus {
                compatible = "fsl,vf610-soc-bus";
                nvmem = <&ocotp>;
                nvmem-names = "ocotp";
                nvmem-cell = <&ocotp_cfg>;
                nvmem-cell-names = "soc_id";
                status = "okay";
        };

I believe my device tree node entries are incorrect. I did like to
use the devm_nvmem_device/cell_get functions and then read using
cell or device consumer API's. I am looking at the NVMEM bindings
but it is not clear to me as to what the correct DT entries and
the corresponding arguments to devm_nvmem_device/cell_get should
be?

Can you help me out with as to what the correct entries and calls
should be?

I currently have
devm_nvmem_device_get(dev, "ocotp");
devm_nvmem_cell_get(dev, "soc_id");

where dev would be the soc-bus device.

Thanks & Regards,
Sanchayan.
