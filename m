From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 04 Apr 2013 10:41:49 -0600
Subject: [PATCH V2 4/7] kbuild: always run gcc -E on *.dts,
 remove cmd_dtc_cpp
In-Reply-To: <515CC317.2000703@elopez.com.ar>
References: <1365032098-22825-1-git-send-email-swarren@wwwdotorg.org>
 <1365032098-22825-4-git-send-email-swarren@wwwdotorg.org>
 <515CC317.2000703@elopez.com.ar>
Message-ID: <515DAD4D.9020100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 06:02 PM, Emilio L?pez wrote:
> Hi Stephen,
> 
> El 03/04/13 20:34, Stephen Warren escribi?:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Replace cmd_dtc with cmd_dtc_cpp, and delete the latter.
>>
>> Previously, a special file extension (.dtsp) was required to trigger
>> the C pre-processor to run on device tree files. This was ugly. Now that
>> previous changes have enhanced cmd_dtc_cpp to collect dependency
>> information from both gcc -E and dtc, we can transparently run the pre-
>> processor on all device tree files, irrespective of whether they
>>
> 
> I think a line got dropped on the commit description by mistake.

Thanks for noticing. I've locally added the following line to the end of
the description, but won't repost unless there's some other reason, or
the series is ack'd enough to actually be applied:

use /include/ or #include syntax to include *.dtsi.
