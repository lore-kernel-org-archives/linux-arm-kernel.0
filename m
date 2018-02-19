From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 19 Feb 2018 11:44:43 +0000
Subject: [PATCH v5 05/20] firmware: arm_scmi: add scmi protocol bus to
 enumerate protocol devices
In-Reply-To: <CAK8P3a1wBBVZnd6ns5K-HhQ28WKAwVbaWsnmE+83SyOnTQt4_w@mail.gmail.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
 <1514904162-11201-6-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a1wBBVZnd6ns5K-HhQ28WKAwVbaWsnmE+83SyOnTQt4_w@mail.gmail.com>
Message-ID: <776fa373-f27f-b32b-6c1f-bb10f257ddc7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/02/18 11:35, Arnd Bergmann wrote:
> On Tue, Jan 2, 2018 at 3:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
>> +#ifdef CONFIG_ARM_SCMI_PROTOCOL
>> +int scmi_driver_register(struct scmi_driver *driver,
>> +                        struct module *owner, const char *mod_name);
>> +void scmi_driver_unregister(struct scmi_driver *driver);
>> +#else
>> +static int scmi_driver_register(struct scmi_driver *driver,
>> +                               struct module *owner, const char *mod_name)
>> +{
>> +       return -EINVAL;
>> +}
>> +static void scmi_driver_unregister(struct scmi_driver *driver) {}
>> +#endif /* CONFIG_ARM_SCMI_PROTOCOL */
> 
> The dummy helpers must be 'static inline', not just 'static', otherwise you
> get a warning when this header is included by a file that doesn't call
> both of them.
> 

Thanks, fixed locally now.

-- 
Regards,
Sudeep
