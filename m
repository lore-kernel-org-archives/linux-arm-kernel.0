From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 May 2012 09:12:50 +0200
Subject: [PATCH 02/12] pinctrl: basic Nomadik pinctrl interface
In-Reply-To: <4FAAD4EB.4010007@wwwdotorg.org>
References: <1336470270-23518-1-git-send-email-linus.walleij@stericsson.com>
 <4FAAD4EB.4010007@wwwdotorg.org>
Message-ID: <CACRpkdaveHBEbpY9bARyooCDb9gX8BMYxfAbX+MSVjXodCAX1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 10:34 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/08/2012 03:44 AM, Linus Walleij wrote:

>> + ? ? /* Poke in other ASIC variants here */
>> + ? ? if (platid->driver_data == PINCTRL_NMK_DB8500)
>> + ? ? ? ? ? ? nmk_pinctrl_db8500_init(&npct->soc);
>
> Other platforms have a unique top-level driver for each variant, with
> the probe() function for each variant calling into a utility function.
> That way, the common/utility code doesn't need to contain a
> table/list/... of all the variants. Can the same approach be used here?

Now I see why I did this, it doesn't show in the patch but this driver
now has two platform_driver structs and two probes.

So I thought it'd be messy to have the two probes in two different
files, with criss-cross calling, as simple as that.

The goal is to merge them into one probe function providing
all resources though, I'm refactoring stepwise since the mess
up in the arch needs to be handled in some separate step
and I have enough hamming distance already as it is ...

I'm rolling a v2 with the other change though.

Yours,
Linus Walleij
