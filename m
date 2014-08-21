From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Thu, 21 Aug 2014 13:32:41 +0200
Subject: [PATCH 3/3] ARM: zynq: DT: Add Ethernet phys
In-Reply-To: <5a7b6f57-b6c0-4fb3-af0d-d403277c0207@BN1AFFO11FD045.protection.gbl>
References: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408550219-19825-3-git-send-email-soren.brinkmann@xilinx.com>
 <5a7b6f57-b6c0-4fb3-af0d-d403277c0207@BN1AFFO11FD045.protection.gbl>
Message-ID: <53F5D8D9.7040604@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.08.2014 10:41, schrieb Michal Simek:
> On 08/20/2014 05:56 PM, Soren Brinkmann wrote:
>> Add missing Ethernet phys to Zynq DTs.
>>
>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>>  arch/arm/boot/dts/zynq-zc702.dts | 6 ++++++
>>  arch/arm/boot/dts/zynq-zc706.dts | 6 ++++++
>>  arch/arm/boot/dts/zynq-zed.dts   | 6 ++++++
>>  3 files changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
>> index 30bcfe20f0bc..fa810505ab8f 100644
>> --- a/arch/arm/boot/dts/zynq-zc702.dts
>> +++ b/arch/arm/boot/dts/zynq-zc702.dts
>> @@ -36,6 +36,12 @@
>>  &gem0 {
>>  	status = "okay";
>>  	phy-mode = "rgmii-id";
>> +	phy-handle = <&ethernet_phy>;
>> +
>> +	ethernet_phy: ethernet-phy at 7 {
>> +		compatible = "marvell,88e1116r", "ethernet-phy-ieee802.3-c22";
> 
> c22 is completely unused by the kernel and also c22 is default option anyway.
> Any advantage to have c22 specified here?

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/phy.txt

S?ren's marvell,* entries do not seem documented, therefore I used the
documented "ethernet-phy-idAAAA.BBBB" based syntax. The documented
example specifically uses -c22, too.

Either it's okay to prepend unrecognized model strings, then you should
update zynq-parallella.dts as well (I put the model in a comment there)
or use the official strings like I used and keep the readable models as
comments. Documenting all those "marvell,88e1116r", "marvell,88e1518",
"marvell,88e1318" PHY bindings and possibly prepending them to the ID
based strings would be another option, of course.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/a79d7fdf/attachment.sig>
