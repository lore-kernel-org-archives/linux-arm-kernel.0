From: eajames@linux.vnet.ibm.com (Eddie James)
Date: Fri, 31 Aug 2018 14:30:02 -0500
Subject: [PATCH 0/4] media: platform: Add Aspeed Video Engine driver
In-Reply-To: <153573819126.93865.1884182656081956202@swboyd.mtv.corp.google.com>
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
 <153573819126.93865.1884182656081956202@swboyd.mtv.corp.google.com>
Message-ID: <a959a032-6817-dcb4-2c5f-b4bd17fc1c8b@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/31/2018 12:56 PM, Stephen Boyd wrote:
> Quoting Eddie James (2018-08-29 14:09:29)
>> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
>> can capture and compress video data from digital or analog sources. With
>> the Aspeed chip acting as a service processor, the Video Engine can
>> capture the host processor graphics output.
>>
>> This series adds a V4L2 driver for the VE, providing a read() interface
>> only. The driver triggers the hardware to capture the host graphics output
>> and compress it to JPEG format.
>>
>> Testing on an AST2500 determined that the videobuf/streaming/mmap interface
>> was significantly slower than the simple read() interface, so I have not
>> included the streaming part.
>>
>> It's also possible to use an automatic mode for the VE such that
>> re-triggering the HW every frame isn't necessary. However this wasn't
>> reliable on the AST2400, and probably used more CPU anyway due to excessive
>> interrupts. It was approximately 15% faster.
>>
>> The series also adds the necessary parent clock definitions to the Aspeed
>> clock driver, with both a mux and clock divider.
> Please let me know your merge strategy here. I can ack the clk patches
> because they look fine from high-level clk driver perspective (maybe
> Joel can take a closer look) or I can merge the patches into clk-next
> and get them into next release while the video driver gets reviewed.

Thanks for taking a look! Probably preferable to get the clk patches 
into clk-next first (though Joel reviewing would be great). I just put 
everything in the same set for the sake of explaining the necessity of 
the clk changes.

Thanks,
Eddie

>
