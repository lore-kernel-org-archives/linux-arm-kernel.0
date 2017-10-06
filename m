From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 6 Oct 2017 10:42:10 +0100
Subject: [PATCH v3 03/22] dt-bindings: arm: scmi: add ARM MHU specific
 mailbox client bindings
In-Reply-To: <20171005232031.7373ni5ssln4wlpr@rob-hp-laptop>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-4-git-send-email-sudeep.holla@arm.com>
 <20171005232031.7373ni5ssln4wlpr@rob-hp-laptop>
Message-ID: <98f8f8fe-1fa6-db1c-73dd-f198d9211a7f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/10/17 00:20, Rob Herring wrote:
> On Thu, Sep 28, 2017 at 02:11:27PM +0100, Sudeep Holla wrote:
>> This patch adds ARM MHU specific mailbox client bindings to support
>> SCMI. Since SCMI specification just requires doorbell mechanism from
>> mailbox controllers, we add mailbox data to specify the doorbell bit(s).
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  .../devicetree/bindings/arm/arm,mhu-scmi.txt          | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/arm,mhu-scmi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,mhu-scmi.txt b/Documentation/devicetree/bindings/arm/arm,mhu-scmi.txt
>> new file mode 100644
>> index 000000000000..8c106f1cdeb8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/arm,mhu-scmi.txt
>> @@ -0,0 +1,19 @@
>> +ARM MHU mailbox client bindings for SCMI Message Protocol
>> +----------------------------------------------------------
>> +
>> +This binding is intended to define the ARM MHU specific extensions to
>> +the generic SCMI bindings[2].
>> +
>> +Required properties:
>> +
>> +The scmi node with the following properties shall be under the /firmware/ node.
>> +
>> +- compatible : shall be "arm,scmi" and "arm,mhu-scmi"
> 
> Most specific first.
> 

Ah right, sorry for missing that.

>> +- mbox-data : For each phandle listed in mboxes property, an unsigned 32-bit
>> +	      data as expected by the mailbox controller
> 
> Shouldn't that be cells as part of mboxes property?
> 

Yes, that's what I proposed with my ARM MHU doorbell bindings[1]. Since
Jassi rejected that and asked to make it part client. But I agree with
you comment. Even Arnd had similar opinion.

-- 
Regards,
Sudeep

[1] https://patchwork.kernel.org/patch/9745683/
