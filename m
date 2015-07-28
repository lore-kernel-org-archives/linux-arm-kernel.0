From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 28 Jul 2015 08:59:35 +0200
Subject: [RFCv2 2/3] dts: zynq: Add devicetree entry for Xilinx Zynq reset
 controller.
In-Reply-To: <CAAtXAHepDRbiiznHnT3dLLLWS_VH2a9BhnNgZzDECx__QceEeg@mail.gmail.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>	<1437783682-13632-3-git-send-email-moritz.fischer@ettus.com>	<55B5D62D.4010407@monstr.eu>
 <CAAtXAHepDRbiiznHnT3dLLLWS_VH2a9BhnNgZzDECx__QceEeg@mail.gmail.com>
Message-ID: <55B72857.3020108@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/07/2015 07:03, Moritz Fischer a ?crit :
> Hi Michal,
> 
> I agree we need to be careful with changing the bindings.
> 
> On Sun, Jul 26, 2015 at 11:56 PM, Michal Simek <monstr@monstr.eu> wrote:
>> Hi Moritz,
>>
>> On 07/25/2015 02:21 AM, Moritz Fischer wrote:
>>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>>> ---
>>>  arch/arm/boot/dts/zynq-7000.dtsi            | 43 ++++++++++++-
>>
>> This patch is nice in general but every change in binding should be
>> discussed separately. There is also necessary to wire them up in the
>> driver to do action. That's why I think that will be the best just to
>> add the code to slcr and keep others untouched.
> 
> Ok, just to clarify: You'd suggest to just add the rstc as child node
> to the slcr,
> and leave the other nodes untouched?
> 
>>
>> For example MACB/GEM is one example. Adding names to this node and
>> extending driver to work properly with reset means that all others MACB
>> users will be affected. Definitely this patch should be ACKed by Nicolas.

Actually, I don't know why a reset property should be added to the macb
driver...

Bye,
-- 
Nicolas Ferre
