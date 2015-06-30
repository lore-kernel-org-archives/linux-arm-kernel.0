From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 30 Jun 2015 11:17:37 +0200
Subject: [RESEND PATCH 1/2] pinctrl: change function behavior for per
 pin muxing controllers
In-Reply-To: <5581988C.50000@wwwdotorg.org>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-2-git-send-email-ludovic.desroches@atmel.com>
 <557EF60D.8020007@wwwdotorg.org> <20150617123816.GB12295@odux.rfo.atmel.com>
 <5581988C.50000@wwwdotorg.org>
Message-ID: <55925EB1.1030500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 17/06/2015 17:55, Stephen Warren a ?crit :
> On 06/17/2015 06:38 AM, Ludovic Desroches wrote:

[..]

>> I have sent patches months ago trying to improve things by having
>> something more flexible. I don't think I introduce too big changes.
>> The only answers I got were from people thinking that pinctrl framework
>> conception is not good to fit all kind of controllers. I re-sent the
>> patch series to gain more expose and have no  answer...
> 
> I don't see anything in your description which implies pinctrl isn't 
> perfectly suitable for your HW.

We are not talking about suitability, we are talking about some little
changes to the generic part, just to have more accurate information and
a little bit more flexibility with our controller.

We read the drivers that Stephen pointed out and it seems that it even
doesn't use the whole generic part of the pinconf. Moreover, we do think
that the statement "one pin" == "one group" leads to a loss of
information and ease of use.
We are not talking about the use of defines, tables, macros to reach an
usable pinctrl: let's say that we have different views.

> Note that I'm on vacation for a couple weeks soon, and I don't expect to 
> follow this conversation during that time. Ultimately, LinusW owns the 
> pinctrl subsystem, and you need to convince him of any changes.

Okay, so we are back at the same situation we had ended up with several
months ago:

- no agreement on 3 points:
1/ ways to use groups in generic pinctrl
2/ ways to describe a comprehensive configuration in device tree
3/ readability of a sysfs information

- no way out on the generic pinctrl little changes that Ludovic proposed
as Linus W. never gave his point of view (RFC posts on April the 2nd).

Ludovic explained at length our point of view and gave detailed
technical arguments. We don't intend to convince you, we just would like
the harmless modifications to be integrated.

As we preferred to give a chance to the generic pinconf/pinctrl for our
use by adding a little bit of flexibility, we are now in a situation
where we are nearly obliged to give up this approach and write a new
driver without the use of the generic facilities: what a pity!
We lost several months of useless work to match what we thought the
maintainer would prefer.

So Linus, do you confirm that we won't go further with this approach?

We are pretty disappointed by the way this interaction with the pinctrl
sub-system went.

Best regards,
-- 
Nicolas Ferre
