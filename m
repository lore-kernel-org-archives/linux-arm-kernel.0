From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 19 Aug 2016 10:00:44 +0200
Subject: [PATCH 01/13] scpi: Add vendor_send_message to enable access to
 vendor commands
In-Reply-To: <c5b2d698-de4c-012a-7e7b-63685b7e898c@arm.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
 <1471515066-3626-2-git-send-email-narmstrong@baylibre.com>
 <c5b2d698-de4c-012a-7e7b-63685b7e898c@arm.com>
Message-ID: <9bf4a979-5325-fd70-1887-04c605d593d8@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2016 05:53 PM, Sudeep Holla wrote:
> 
> 
> On 18/08/16 11:10, Neil Armstrong wrote:
>> Adds an optional vendor_send_message to the scpi to enable sending
>> vendor platform specific commands to the SCP firmware.
>>
> 
> I don't see any users of vendor_send_message in this series, so I prefer
> it to be dropped and introduced when required.
> 
> Also I had a different view on how to introduce this[1]. I would rather
> wait until the requirement comes that enables us to make use of it.
> Looks like you took parts of it and introduces vendor_send_message
> allowing users to send any data which I don't like especially without
> knowing how will it be (ab)used.
> 

Hi Sudeep,

Indeed, I won't ask you to merge patches 1, 8 and 9, they need refactoring and
a separate patchset.

Vendor commands are not necessary for Amlogic, this is a nice to have since they
have a "user" command that can be extended by a firmware loaded by u-boot.

Could you review the following patches and I'll post a reduced v2 ASAP.

Thanks,
Neil
