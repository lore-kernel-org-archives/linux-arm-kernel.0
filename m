From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 5 Apr 2017 14:58:13 +0100
Subject: [Query] DT warnings with ranges and sub-nodes
Message-ID: <5b1fc8af-b5e1-75bd-6cf3-84ea75e4987f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

I am seeing some warning in juno DTS files. I would like to get your
feedback on how to resolve them.

Warning messages:

Warning (simple_bus_reg): Node /smb at 8000000/motherboard/flash at 0,00000000
simple-bus unit address format error, expected "0"
Warning (simple_bus_reg): Node
/smb at 8000000/motherboard/ethernet at 2,00000000 simple-bus unit address
format error, expected "200000000"
Warning (simple_bus_reg): Node
/smb at 8000000/motherboard/iofpga at 3,00000000 simple-bus unit address
format error, expected "300000000"

We have

        smb at 8000000 {
                compatible = "simple-bus";
                #address-cells = <2>;
                #size-cells = <1>;
                ranges = <0 0 0 0x08000000 0x04000000>,
                         <1 0 0 0x14000000 0x04000000>,
                         <2 0 0 0x18000000 0x04000000>,
                         <3 0 0 0x1c000000 0x04000000>,
                         <4 0 0 0x0c000000 0x04000000>,
                         <5 0 0 0x10000000 0x04000000>;
		...
	
		flash at 0,00000000 {
			...
		};
		ethernet at 2,00000000 {
			...
		};
		iofpga at 3,00000000 {
			...
		};
	};

All of which are @offset 0x0 in their respective ranges.

How do we specify the range as well as the offset ? Does the below
look like correct way of fixing those warnings ?
	flash at 0
	ethernet at 200000000
	iofpga at 300000000

Or can I ignore these warning as I see the syntax to be correct as
provided in example in ePAPR(page 99 under Appendix B1 Ebony Device
Tree). Sorry if I have missed to follow any other thread on the same.

-- 
Regards,
Sudeep
