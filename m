From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 19 Jan 2016 20:03:01 +0100
Subject: [LINUX PATCH 2/5] Documentation: mmc: Updated the binding doc for
 Arasan SDHCI.
In-Reply-To: <20160119171940.GA7207@rob-hp-laptop>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <1453213055-35563-2-git-send-email-lakshmis@xilinx.com>
 <20160119171940.GA7207@rob-hp-laptop>
Message-ID: <569E8865.1030504@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.1.2016 18:19, Rob Herring wrote:
> On Tue, Jan 19, 2016 at 07:47:32PM +0530, P L Sai Krishna wrote:
>> This patch adds broken-tuning property to the binding
>> doc for Arasan SDHCI.
>>
>> Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index da541c3..2088d9f 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -17,6 +17,10 @@ Required Properties:
>>    - interrupt-parent: Phandle for the interrupt controller that services
>>  		      interrupts for this device.
>>  
>> +Optional Properties:
>> +  - broken-tuning: Indicates tuning broken in Silicon 1.0 of
>> +			  Zynq Ultrascale+ MPSoC.
>> +
> 
> Make this a standard property.
> 
> Or use the compatible string to determine this. Si errata is exactly 
> what they are for.

I still think that having interface for runtime Silicon version
detection in generic way is much better than using compatible strings
for certain silicon version.
The same board revisions can have different silicon versions.

Asking secure monitor for this information and based on that setup
quirks for this case would be preferred solution.
I want to spend some time to share information about silicon via soc bus
to user space and there should be similar way for sharing this
information inside the kernel.

Thanks,
Michal
