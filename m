From: robherring2@gmail.com (Rob Herring)
Date: Wed, 01 Jun 2011 14:01:03 -0500
Subject: [PATCH 3/3] ARM: l2x0: Add OF based initialization
In-Reply-To: <BANLkTik86CVS0cWOnapnh7dn5F1EOCsmVw@mail.gmail.com>
References: <1306946270-18379-1-git-send-email-robherring2@gmail.com>	<1306946270-18379-4-git-send-email-robherring2@gmail.com>
	<BANLkTik86CVS0cWOnapnh7dn5F1EOCsmVw@mail.gmail.com>
Message-ID: <4DE68C6F.4000904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2011 01:40 PM, Olof Johansson wrote:
> On Wed, Jun 1, 2011 at 9:37 AM, Rob Herring<robherring2@gmail.com>  wrote:
>> From: Rob Herring<rob.herring@calxeda.com>
>>
>> This adds probing for pl310 cache controller via device tree. An example
>> binding looks like this:
>>
>> L2: l2-cache {
>>         compatible = "arm,pl310-cache", "cache";
>
> "cache" is too generic to be useful. "arm,pl2x0-cache" would be a more
> meaningful fallback, I think?

I agree. This is what ePAPR says should be present for caches along with 
a more specific string.

Based on the prior discussion on pmu naming, it should be the specific 
model. There is no such thing as a pl2x0. The models of L2 controllers 
the cache-l2x0.c code supports are:

PL310
L220
L210

And my compatible strings reflect that.

>
> (Same comment as for 1/3: The bindings need to be documented. Same
> applies to 2/3, obviousy).
>

Will do.

Rob
