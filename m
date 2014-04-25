From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Apr 2014 13:31:54 +0200
Subject: [GIT PULL v3] Xilinx Zynq changes for v3.15
In-Reply-To: <5729174.EqI67ku3fz@wuerfel>
References: <53061EBA.1080002@monstr.eu> <201404251100.51068.arnd@arndb.de>
 <535A2F93.3010304@monstr.eu> <5729174.EqI67ku3fz@wuerfel>
Message-ID: <535A47AA.7060804@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> There is just ps-clk-frequency which is user setup and come externally.
>> The part of this is clock driver which is probably that problematic one
>> but on the other hand it is targetting exact register addresses which
>> are used by this driver to describe internal clk description.
> 
> If you just have a 'ps-clk-frequency' property, that should still keep
> the node inside of the SoC. If this had been modeled as a fixed-rate
> clock node as the clock parent of the xlnx,ps7-clkc node, that one
> should have been outside.
> 
> I don't think it's worth changing it now, just something to keep in
> mind.

ok.

>> If you have any example how this should be done, please send it to me.
>> I would like to have this in good shape.
> 
> From all I can tell, all the nodes you have today actually make sense being
> part of the soc device hierarchy. The only problem is that there is no
> way to add nodes outside of it if that becomes necessary.
> 
> Generally speaking, the hierarchy should reflect the actual hardware layout,
> which usually has multiple levels of nested buses, starting with an AXI
> bus that contains the high-speed devices along with bridges to lower-speed
> buses. You probably have access to documentation that describes the
> real layout, so try to match that to the degree that you can, and move the
> pmu into whatever bus you need.
> 
> Then change the code to match the top-level bus node with the soc0 device.

For static devices which we have now is axi bus for soft IPs just nested bus
and should be added to soc0.

That means not a problem with current layout at all and this SOC_BUS
patch can be just added. And I will take care when we have something
what it is out of SoC that it is also added to the proper location out
of this soc node.
Can I add you ACK to this SOC_BUS patch?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/11119519/attachment-0001.sig>
