From: monstr@monstr.eu (Michal Simek)
Date: Thu, 13 Jun 2013 07:02:51 +0200
Subject: [PATCH v2 3/3] arm: dt: zynq: Add support for the zed platform
In-Reply-To: <d7057a7e-fc92-4e24-bf7b-137e873f871b@VA3EHSMHS011.ehs.local>
References: <1371055268-32337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1371055268-32337-4-git-send-email-soren.brinkmann@xilinx.com>
 <20130612182345.GA1656@pengutronix.de>
 <2433e1d1-7d2e-4b23-a76e-2085e3aef1a6@DB9EHSMHS010.ehs.local>
 <20130612193358.GA21585@pengutronix.de>
 <d7057a7e-fc92-4e24-bf7b-137e873f871b@VA3EHSMHS011.ehs.local>
Message-ID: <51B9527B.904@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2013 10:16 PM, S?ren Brinkmann wrote:
> On Wed, Jun 12, 2013 at 09:33:58PM +0200, Steffen Trumtrar wrote:
>> On Wed, Jun 12, 2013 at 11:26:34AM -0700, S?ren Brinkmann wrote:
>>> On Wed, Jun 12, 2013 at 08:23:45PM +0200, Steffen Trumtrar wrote:
>>>> On Wed, Jun 12, 2013 at 09:41:08AM -0700, Soren Brinkmann wrote:
>>>>> Add a DT fragment for the Zed Zynq platform and a corresponding
>>>>> target to the Makefile
>>>>>
>>>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>>>> ---
>>>>> I used the 'xlnx,...' compat strings since it seems this is what is
>>>>> used in the Xilinx and Digilent vendor trees.
>>>>>
>>>>> +/include/ "zynq-7000.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +	model = "Zynq Zed Development Board";
>>>>> +	compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
>>>>> +
>>>>> +	memory {
>>>>> +		device_type = "memory";
>>>>> +		reg = <0 0x20000000>;
>>>>> +	};
>>>>> +
>>>>> +	chosen {
>>>>> +		bootargs = "console=ttyPS1,115200 earlyprintk";
>>>>> +	};
>>>>> +
>>>>> +};
>>>>
>>>> Hi!
>>>>
>>>> This looks a little bit to basic. No?! Not even an UART?
>>> The UART is imported from the common zynq-7000.dtsi.
>>
>> Hm, you are actually right, although I think that you shouldn't be.
>> It is possible to NOT use the UARTs, isn't it? So, default on for both UARTs is wrong.
> Well, in that case the dtsi has to be fixed to add the 'status = "disabled"
> property to the UARTs which then can be overridden in the board dts files
> as needed. I guess I'll prepare another patch for a v3 for adding status
> properties to the UART nodes.

I am ok with this. Just to be sure that we will probably need to start
to use port-number to reflect which port is first, second.


>>>> The compatible should include digilent or avnet. Digilent only sells to academic
>>>> customers, Avnet doesn't.
>>> I don't care at all. So, who makes the decision which one is the correct
>>> one? Actually we could even drop the zed specific one completely and go
>>> with 'xlnx,zynq-7000' only.
>>
>> I'm okay with that.
> Okay, let's wait a little and see if there are other opinions and then I
> can prepare a v3.

AFAIK Digilent is producer, Avnet is reseller. I think it is enough to write
in description ZedBoard and don't mentioned manufacturer.

By my previous comment I thought to have there just zynq-7000 compatible string
without any additional zc702/zc706 or zed board properties.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130613/6da2722c/attachment.sig>
