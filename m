From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Feb 2017 17:35:44 +0000
Subject: [RFT PATCH 1/2] ARM: module: split core and init PLT sections
In-Reply-To: <CAMZqy1CWNC2aL4Qhp2C9M0POuU4juz2=L8WpoihRUdWT6uhiGg@mail.gmail.com>
References: <1487628041-2147-1-git-send-email-ard.biesheuvel@linaro.org>
 <1487628041-2147-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAMZqy1CWNC2aL4Qhp2C9M0POuU4juz2=L8WpoihRUdWT6uhiGg@mail.gmail.com>
Message-ID: <CAKv+Gu-qPuVjw4BMdDkWx8jmW2Vt-Uiv7xz-PcTCvMm18+SLWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 February 2017 at 14:26, Angus Clark <angus@angusclark.org> wrote:
> Hi Ard,
>
> I have tested the patch and I think there is still a small issue.  At
> present, count_plts() assumes a PLT entry would only be required for
> undefined symbols.  However, if 'init' and 'core' are located far
> apart, then we may need an entry in the init PLT if some init code
> makes a call to a defined symbol in the core section.
>

Argh. You're absolutely right, another complication I did not
anticipate, unfortunately.

> As a quick test, I added an 'include_defined' argument to count_plts()
> which gets set for init relocs.  With this in place, the module loads
> fine and appears to function as expected.
>
> Happy to test any further versions :-)
>

Thanks, v2 coming up
