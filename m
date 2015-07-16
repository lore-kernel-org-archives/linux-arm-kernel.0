From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 16 Jul 2015 22:44:42 +0200
Subject: [PATCH] ARM: pxa: fix dm9000 platform data regression
In-Reply-To: <55A61873.7090209@compulab.co.il> (Igor Grinberg's message of
 "Wed, 15 Jul 2015 11:23:15 +0300")
References: <1436657520-16972-1-git-send-email-robert.jarzmik@free.fr>
 <55A61873.7090209@compulab.co.il>
Message-ID: <87lhefj0hx.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Igor Grinberg <grinberg@compulab.co.il> writes:

> Hi Robert,
>
> On 07/12/15 02:32, Robert Jarzmik wrote:
>> Since dm9000 driver added support for a vcc regulator, platform data
>> based platforms have their ethernet broken, as the regulator claiming
>> returns -EPROBE_DEFER and prevents dm9000 loading.
>> 
>> This patch fixes this for all pxa boards using dm9000, by using the
>> specific regulator_has_full_constraints() function.
>> 
>> This was discovered and tested on the cm-x300 board.
>> 
>> Fixes: 7994fe55a4a2 ("dm9000: Add regulator and reset support to dm9000")
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Thanks for the patch!
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
Thanks. Queued into pxa/fixes.

Cheers.

--
Robert
