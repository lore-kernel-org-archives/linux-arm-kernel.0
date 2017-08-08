From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 8 Aug 2017 16:57:54 +0530
Subject: [PATCH v2 03/18] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <3279524c-d3e5-fe0f-ba7d-f715bfdcad9c@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-4-git-send-email-sudeep.holla@arm.com>
 <CABb+yY0DQ1H8Apb6PoqKg-HrTfbyxShum9YtJit96T4Yo9+zrQ@mail.gmail.com>
 <3279524c-d3e5-fe0f-ba7d-f715bfdcad9c@arm.com>
Message-ID: <CABb+yY3rLAB6F8VtuExaBch1b-hTfqHDzO0ADsJd9Z7JkNfQ8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 8, 2017 at 2:59 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 08/08/17 03:46, Jassi Brar wrote:
>> On Fri, Aug 4, 2017 at 8:01 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> ....
>>> +int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>>> +{
>>> +       int ret;
>>> +       int timeout;
>>> +       struct scmi_info *info = handle_to_scmi_info(handle);
>>> +       struct device *dev = info->dev;
>>> +
>>> +       ret = mbox_send_message(info->tx_chan, xfer);
>>>
>> NAK
>>
>> This is still not fixed. For the reasons mentioned many times like
>> here...   https://lkml.org/lkml/2017/7/7/465
>>
>
> Since SCPI and SCMI are based on doorbell designs like ACPI PCC, they
> can't send any data as all the data are part of shared memory.
>
> What data needs to be sent from SCPI/SCMI as part of mbox_send_message
> in your opinion ? I can't think of any generic way to form this data.
>
https://lkml.org/lkml/2017/7/7/290
