From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 5 Sep 2017 14:45:01 +0100
Subject: [PATCH v2 04/18] firmware: arm_scmi: add common infrastructure
 and support for base protocol
In-Reply-To: <9a6b0722-1299-fb0a-6c75-9aceb248659f@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-5-git-send-email-sudeep.holla@arm.com>
 <9a6b0722-1299-fb0a-6c75-9aceb248659f@arm.com>
Message-ID: <42d72579-07cd-798d-34e9-b9c584048b64@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/09/17 14:39, Julien Thierry wrote:

[...]

>> diff --git a/drivers/firmware/arm_scmi/driver.c
>> b/drivers/firmware/arm_scmi/driver.c
>> index 139d6980f270..601d0d7210d9 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -108,18 +108,22 @@ struct scmi_desc {
>>    * @dev: Device pointer
>>    * @desc: SoC description for this instance
>>    * @handle: Instance of SCMI handle to send to clients
>> + * @version: SCMI revision information containing protocol version,
>> + *    implementation version and (sub-)vendor identification.
>>    * @cl: Mailbox Client
>>    * @tx_chan: Transmit mailbox channel
>>    * @rx_chan: Receive mailbox channel
>>    * @tx_payload: Transmit mailbox channel payload area
>>    * @rx_payload: Receive mailbox channel payload area
>>    * @minfo: Message info
>> + * @protocols_imp: list of protocols implemented
>>    * @node: list head
>>    * @users: Number of users of this instance
>>    */
>>   struct scmi_info {
>>       struct device *dev;
>>       const struct scmi_desc *desc;
>> +    struct scmi_revision_info version;
>>       struct scmi_handle handle;
>>       struct mbox_client cl;
>>       struct mbox_chan *tx_chan;
>> @@ -127,6 +131,7 @@ struct scmi_info {
>>       void __iomem *tx_payload;
>>       void __iomem *rx_payload;
>>       struct scmi_xfers_info minfo;
>> +    u8 *protocols_imp;
> 
> Both the base protocol and driver part rely on this being of size
> MAX_PROTOCOLS_IMP (if existing).
> 
> Could this be a "u8 protocols_imp[MAX_PROTOCOLS_IMP]" instead? 

Sounds better, will update accordingly.

-- 
Regards,
Sudeep
