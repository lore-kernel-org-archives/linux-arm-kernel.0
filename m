From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 24 Apr 2014 07:11:46 +0800
Subject: [PATCH] ARM: prima2: remove L2 cache size override
In-Reply-To: <20140423182127.GJ24070@n2100.arm.linux.org.uk>
References: <1397555342-25644-1-git-send-email-21cnbao@gmail.com>
 <20140416092433.GG24070@n2100.arm.linux.org.uk>
 <20140423182127.GJ24070@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4xsTOTdpK0GM4mud4Brq7EnttpLbxtdnPGiS=qQuimVGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-24 2:21 GMT+08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Apr 16, 2014 at 10:24:33AM +0100, Russell King - ARM Linux wrote:
>> On Tue, Apr 15, 2014 at 05:49:02PM +0800, Barry Song wrote:
>> > +static __init void sirfsoc_init_mach(void)
>> > +{
>> > +   l2x0_of_init(0, 0xFDFFFFFFUL);
>>
>> BTW, this should be just the plain: 0xfdffffff - no need for UL on the
>> end.  Also lower case is preferred for hex.
>
> So... I provide feedback, and nothing happens.
>
> FYI, tonight, I'm pushing out my L2C branch into linux-next with the
> original patch for prima2 incorporated, as my concerns against your
> patch have not been addressed.

Russell, i do agree with your feedback.
but, in your original patch,  moving to early_initcall will make other
non-csr platforms call l2x0_of_init() and finish initialization by (0,
~0) directly since other platforms also put same general compatible
prop in dts. in your patch, you have dropped "sirf,prima2-pl310-cache"
and "sirf,marco-pl310-cache", so it happens by matching general
"arm,pl310-cache".
i am still on the way to send v2. if it is not too urgent to you, will
you wait for me to send v2 by fixing issues in your feedback?

>

-barry
