From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Wed, 29 Jan 2014 10:59:12 -0600
Subject: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
In-Reply-To: <CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>	<1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>	<20140117110830.GW3471@alberich>	<52E92842.3000001@amd.com>
 <CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com>
Message-ID: <52E93360.1000904@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/29/2014 10:57 AM, Rob Herring wrote:
>>> diff --git a/include/linux/of.h b/include/linux/of.h
>>> >>index 276c546..24e1b28 100644
>>> >>--- a/include/linux/of.h
>>> >>+++ b/include/linux/of.h
>>> >>@@ -67,7 +67,7 @@ struct device_node {
>>> >>   #endif
>>> >>   };
>>> >>
>>> >>-#define MAX_PHANDLE_ARGS 8
>>> >>+#define MAX_PHANDLE_ARGS 16
>> >
>> >
>> >Since the MMU-500 specify "Number of SMRs" upto 128 registers, shouldn't
>> >this be changed to be able to support 128 StreamIDs as well?  Although I am
>> >not sure if this would be too big to have on the stack per Rob's comment in
>> >the previous patch set.
> Do you actually need 128 now? If not, then we can deal with that when
> we get there. There are lots of things in spec's that are not actually
> implemented or supported.

Actually, we are using 32 on the AMD system. So, do you think we can set 
this to 32 instead?

Thanks,

Suravee
