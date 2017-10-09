From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 9 Oct 2017 07:42:55 +0200
Subject: [PATCH 1/2] arm: dts: Add support for National Instruments
 Project Sulfur SDRs
In-Reply-To: <20171006161808.GA14871@tyrael.ni.corp.natinst.com>
References: <20170911232223.91894-1-mdf@kernel.org>
 <314acb1f-1f0f-7893-70a8-9379c01112ac@xilinx.com>
 <20170925161136.GA12943@tyrael.ni.corp.natinst.com>
 <6b87e902-3201-6710-4921-d465dea19dcd@xilinx.com>
 <20170926175018.GA14962@tyrael.ni.corp.natinst.com>
 <dfb517fe-8584-2a1a-22e5-946980cc9644@balister.org>
 <a606ab17-6fb9-2ce1-3b3b-5a2e72d3fc7c@xilinx.com>
 <3b41cfc0-08b7-853d-3439-7f9848d04d3c@balister.org>
 <58fe4e6c-8765-bd9a-0698-8f8326f95e40@xilinx.com>
 <20171006161808.GA14871@tyrael.ni.corp.natinst.com>
Message-ID: <78aba405-5c2b-7c8c-bc41-6e93b3ff8563@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6.10.2017 18:18, Moritz Fischer wrote:
> On Fri, Oct 06, 2017 at 01:49:44PM +0200, Michal Simek wrote:
>> On 26.9.2017 20:15, Philip Balister wrote:
>>> On 09/26/2017 02:06 PM, Michal Simek wrote:
>>>> On 26.9.2017 19:58, Philip Balister wrote:
>>>>> On 09/26/2017 01:50 PM, Moritz Fischer wrote:
>>>>>> Michal,
>>>>>>
>>>>>> On Tue, Sep 26, 2017 at 02:54:48PM +0200, Michal Simek wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 25.9.2017 18:11, Moritz Fischer wrote:
>>>>>>>> Hi Michal,
>>>>>>>>
>>>>>>>> On Mon, Sep 25, 2017 at 10:19:44AM +0200, Michal Simek wrote:
>>>>>>>>> Hi Moritz
>>>>>>>>>
>>>>>>>>> sorry for delay.
>>>>>>>>
>>>>>>>> No problem.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 12.9.2017 01:22, Moritz Fischer wrote:
>>>>>>>>>> Add support for the National Instruments Project Sulfur SDR
>>>>>>>>>> motherboards Rev 2,3 and 4.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>>>>>>>>>> ---
>>>>>>>>>>  arch/arm/boot/dts/Makefile                |   3 +
>>>>>>>>>>  arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts |  84 +++++++++++++++++++
>>>>>>>>>>  arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts | 118 ++++++++++++++++++++++++++
>>>>>>>>>>  arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts |  26 ++++++
>>>>>>>>>>  arch/arm/boot/dts/zynq-ni-sulfur.dtsi     | 133 ++++++++++++++++++++++++++++++
>>>>>>>>>>  5 files changed, 364 insertions(+)
>>>>>>>>>>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts
>>>>>>>>>>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts
>>>>>>>>>>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts
>>>>>>>>>>  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur.dtsi
>>>>>>>>>
>>>>>>>>> Is this publicly available board?
>>>>>>>>
>>>>>>>> Will be in Q1 2018 was announced at GRCon'17 ([1]).
>>>>>>>> Some of the Rev3s are currently deployed in Norway as part of a radar
>>>>>>>> system.
>>>>>>>>
>>>>>>>>> I am not quite sure we should apply these dts files. There are a lot of
>>>>>>>>> boards with zynq and there must be any strong argument for applying this
>>>>>>>>> to the tree. For arm32 with even flat tree structure.
>>>>>>>>
>>>>>>>> What's the issue with merging them, except for having 3 more files? 
>>>>>>>
>>>>>>> For me this is not a problem because on Linux side it is not increasing
>>>>>>> build time.
>>>>>>> I want to see the value for community. All xilinx platforms are
>>>>>>> evaluation generic purpose boards which are showing how to connect stuff
>>>>>>> together.
>>>>>>> On the other hand this is real product.
>>>>>>
>>>>>> Uh.
>>>>>>
>>>>>>> I would let arm-soc maintainer to decide if this is fine or not. I
>>>>>>> definitely don't want to end up in situation that we will have dts for
>>>>>>> real products which are not bringing any value for others.
>>>>>>
>>>>>> Sure, it's the maintainers call.
>>>>>>
>>>>>> I do intend to have my customers run mainline on it eventually, currently
>>>>>> I'm a handful of patches away from making that happen. So yes, running
>>>>>> mainline is a usecase that matters to me.
>>>>>>
>>>>>> It is one thing to keep bitching about vendor kernels as a community
>>>>>> continuously, but then if someone goes through the effort and actually
>>>>>> tries to run mainline, you give them crap like that above.
>>>>>>
>>>>>> Our products usually come with full schematics [1], firmware, fpga code and all
>>>>>> available, I don't know what makes them less useful to the community as a
>>>>>> platform to experiment and develop on than Xilinx eval boards.
>>>>>>
>>>>>> There's several people that I know of both hobbyists and companies that
>>>>>> build systems around these platforms, so I don't know ...
>>>>>
>>>>> I expect this product to be delivered with full source and a mainline
>>>>> kernel, so lets make it easy for Moritz to do the right thing here. This
>>>>> makes long term support of this product much easier.
>>>>>
>>>>> Acked-by: Philip Balister <philip@opensdr.com>
>>>>
>>>> I think this is the right way to go. Get ACK from Arnd or Olof or Kevin
>>>> and I will merge this.
>>>> I am simply just afraid that if a lot of zynq customers will ask for it
>>>> we can will end up with a lot of zynq/zynqmp based dts files in the
>>>> kernel and arm-soc guys will stop this that it is simply too much and
>>>> won't accept +1 case.
>>>
>>> I share the same concerns. Unfortunately, there doesn't seem like any
>>> other structured way to manage dts files.
>>>
>>> As an OpenEmbedded guy, I know I can carry them with BSP's, but not
>>> everyone uses OpenEmbedded. I'd love to see a long term scalable
>>> solution for tracking dts files, but that is outside the scope of
>>> Moritz's request.
>>
>> Are you guys coming to ELCE? There will be Devicetree Workshop which
>> will be good place to talk about this.
> 
> Yeah, it's on Thursday, right?

Yep Thursday but no exact time yet.

M
