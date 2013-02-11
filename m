From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 11 Feb 2013 18:17:41 +0100
Subject: [PATCH 1/2] ARM: at91: create ebi read/write interface for RM9200
In-Reply-To: <20130211164929.GI30595@game.jcrosoft.org>
References: <1360425268-29060-1-git-send-email-manabian@gmail.com>
 <1360425268-29060-2-git-send-email-manabian@gmail.com>
 <20130211164929.GI30595@game.jcrosoft.org>
Message-ID: <CAGhQ9Vys6qGH1TNOwJ_F7mveNRh0kW6G3c5DjQ38ueAAww0D7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 February 2013 17:49, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 16:54 Sat 09 Feb     , Joachim Eastwood wrote:
>> Introduce ebi read/write functions on AT91RM9200 to make
>> it possible to have a common SDRAMC header and driver.
>>
>> SDRAMC register layout is more or less the same on RM9200
>> and SAM926x. The only difference is the header file for
>> RM9200 uses a different offset on SDRAMC registers. The
>> offset used is actually for RM9200 MC.
>>
>> By using the real base for SDRAMC on RM9200 header files
>> can be shared. With this change there are also no users
>> of ramc outside mach-at91.
>
> nack the idea is wrong on rm9200 we have sdramc that do ram controler + EBI
>
> and the EBI is completly soc dependant
>
> and you have 2 ebi on 9263 and 9g45 so the no

Well, the at91_ebi_read/write functions in this patch was only meant
for RM9200. Guess I should have called it at91rm9200_ebi_read/write or
something.

Anyway; my goal is to create an EBI driver for AT91RM9200 which will
use DT to setup EBI/SMC for devices hooked up to EBI. This driver will
live in drivers/bus. The sdramc "driver" can continue to live in
mach-at91 but the handling of EBI and SMC will move into a proper
driver.

Do you a better approach?

The two patches I posted was only a clean up to prepare for a proper
driver living in drivers/bus. I'll try to finish up the rest of the
series so you see the whole picture.


regards
Joachim Eastwood
