From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 20 Jan 2017 20:34:29 +0100
Subject: [PATCH v3 01/15] ARM: pxa: Don't rely on public mmc header to
 include leds.h
In-Reply-To: <CAPDyKFo=tUu9D5zZnUME_+HFBPEnnjy2taTdFLO9H6jSSgKc5A@mail.gmail.com>
 (Ulf Hansson's message of "Fri, 20 Jan 2017 09:27:29 +0100")
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-2-git-send-email-ulf.hansson@linaro.org>
 <87efzydusi.fsf@belgarion.home>
 <CAPDyKFo=tUu9D5zZnUME_+HFBPEnnjy2taTdFLO9H6jSSgKc5A@mail.gmail.com>
Message-ID: <87a8aleda2.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 20 January 2017 at 09:01, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>> So I was wondering how you made the choice of which files you add the include to
>> and which you don't touch ?
>
> By building the pxa_defconfig, see what errors it reports and then fix them.
>
> Isn't pxa_defconfig building all the variants?
Euh actually it should, but it's not.

The file was built from all _existing_ pxa defconfigs in arch/arm/configs/. The
trick is that there were many pxa boards for which no defconfig file was
available, and therefore they "escape" the pxa_defconfig coverage.

Cheers.

-- 
Robert
