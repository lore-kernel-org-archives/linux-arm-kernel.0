From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 11 Dec 2014 11:49:54 +0100
Subject: [RFC 04/15] regulator: add restrack support
In-Reply-To: <20141210160720.GS11764@sirena.org.uk>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
 <1418226513-14105-5-git-send-email-a.hajda@samsung.com>
 <20141210160720.GS11764@sirena.org.uk>
Message-ID: <548976D2.7080005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 12/10/2014 05:07 PM, Mark Brown wrote:
> On Wed, Dec 10, 2014 at 04:48:22PM +0100, Andrzej Hajda wrote:
>> Regulators supports various methods of lookup.
>> The patch adds restrack support only to DT based regulators.
> Why, what does this mean and how might one use it?  I've not looked at
> the code since I don't know what it's supposed to accomplish...

Looking at this patch makes no sense without looking at cover letter
or at the patch adding restrack framework. In short adding restrack support
to regulators will allow to:
- proper handle regulator provider unbind/re-bind, currently it results
in oopses, crashes and hangs,
- avoid late probe due to deferred probing, currently if probe is
deferred, re-probe occurs in late initcall,
- track appearance of resources which can alter behavior of the driver
if present but they are not required,
  I am not sure if there are use cases for it in case of regulators, but
other resources have such use cases,
- as a bonus we can have simpler allocation of various resources, please
look at cover letter for example.

>
> One very high level thing is that anything that only works for DT only
> seems to be a non-starter, the API should be hiding details of the
> firmware interface.

I agree, but as this is RFC, not everything is finished. It seems I have
forgotten to mention it clearly in cover
letter.
Anyway it seems I should adjust patchset and move matching code from
restrack/track core to specific frameworks.
This way any current or future lookup method should be supported.

But the main purpose of this patchset is to get opinions, if the main
ideas are OK. And if the patchset can be
eventually accepted.

Regards
Andrzej
