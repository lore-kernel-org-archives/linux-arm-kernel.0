From: ian@slimlogic.co.uk (Ian Lartey)
Date: Fri, 08 Mar 2013 17:12:47 +0000
Subject: [PATCH v8 0/12] Palmas Updates
In-Reply-To: <CACRpkdYHhh=ANiHvgxXiAQ_4LLiBBe0AfJ-60Wy6aEi7Cv0HOg@mail.gmail.com>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
 <513894E3.1070206@slimlogic.co.uk>
 <CACRpkdYHhh=ANiHvgxXiAQ_4LLiBBe0AfJ-60Wy6aEi7Cv0HOg@mail.gmail.com>
Message-ID: <513A1C0F.3070602@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/13 07:12, Linus Walleij wrote:
> On Thu, Mar 7, 2013 at 2:23 PM, Ian Lartey <ian@slimlogic.co.uk> wrote:
>
>> This patchset adds to the support for the Palmas iseries of PMIC chips.
>>
>> Some of the patches have previously been submitted individually.
>> The DT bindings doc has been added first due to comments that it was
>> missing.
>
> Can the patches to the individual subsystems be applied individually
> (like can we apply the two GPIO patches to the GPIO tree) or are
> the deps such that the whole shebang needs to go in at once and you're
> just harvesting ACKs to take it all into MFD or similar?

There are a few dependencies:

The GPIO and LEDS subsystem patches both depend on:
[PATCH v8 02/12] mfd: palmas: is_palmas_charger needed by multiple drivers

all the subsystems depend on:
[PATCH v8 01/12] mfd: DT bindings for the palmas family MFD
for their DT documentation.

so taking the whole shooting match in one go seems the safest.

>
> Yours,
> Linus Walleij


Regards,

Ian
