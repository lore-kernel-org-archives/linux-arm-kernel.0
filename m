From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 12 Dec 2013 11:14:10 +0100
Subject: regulator-core has_full_constraints set too late for dt using
 boards ?
In-Reply-To: <20131211160225.GB11468@sirena.org.uk>
References: <52A88805.1080704@redhat.com>
 <20131211160225.GB11468@sirena.org.uk>
Message-ID: <52A98C72.2040203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/11/2013 05:02 PM, Mark Brown wrote:
> On Wed, Dec 11, 2013 at 04:43:01PM +0100, Hans de Goede wrote:
>
>> While looking into making regulator_get_optional not print
>> an error when no regulator is found, I've noticed that
>> for dt enabled boards, has_full_constraints is not set
>> until regulator_init_complete() runs, which is a
>> late_initcall.
>
>> This means that it gets set after it has already been checked
>> from calls like regulator_get which are likely done by init
>> functions running earlier.
>
>> This seems wrong ...
>
> Please look at the current code, that's not how this works any more.

More current then 3.13-rc3 ? Because that is what I've been looking at.

I could be completely wrong of course. Either way could you give a few
hints as to how my interpretation of how this works is wrong ?

Thanks & Regards,

Hans
