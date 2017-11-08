From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 8 Nov 2017 16:33:41 +0000
Subject: [PATCH v4 03/20] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <CABb+yY0KR7rzUSqrG7vPJDZONK3rXtk03WX2eTGAdmkpvTUEbw@mail.gmail.com>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com>
 <1509720477-18936-4-git-send-email-sudeep.holla@arm.com>
 <CABb+yY0KR7rzUSqrG7vPJDZONK3rXtk03WX2eTGAdmkpvTUEbw@mail.gmail.com>
Message-ID: <d51a66a0-9272-ff93-ff99-28d0928950a8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On 04/11/17 11:51, Jassi Brar wrote:
> On Fri, Nov 3, 2017 at 8:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> .....
> 
>> +int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>> +{
>> +       int ret;
>> +       int timeout;
>> +       struct scmi_info *info = handle_to_scmi_info(handle);
>> +       struct device *dev = info->dev;
>> +
>> +       ret = mbox_send_message(info->tx_chan, xfer);
>>                                                                           ^^^^^^^^
> The call still remains unchanged and broken.
> https://lkml.org/lkml/2017/7/24/502
> 

Yes, since you are in favor of abstraction on top of mailbox while Arnd,
Bjorn, and me prefer to deal with that in mailbox framework itself, I
thought I will keep that discussion separate and get the remaining parts
of SCMI reviewed.

I have not forgotten about it, just trying to keep it separate. Sorry, I
could have been more specific.

-- 
Regards,
Sudeep
