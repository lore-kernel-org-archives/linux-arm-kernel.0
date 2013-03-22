From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Mar 2013 14:36:28 +0100
Subject: [PATCH 0/9] More ux500 multiplatform stuff
In-Reply-To: <201303221334.07330.arnd@arndb.de>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
 <CACRpkdbaRyHxeJM=JT+9CtVf-_u90wCzjePDvsNq-EQd_NxLdg@mail.gmail.com>
 <201303221334.07330.arnd@arndb.de>
Message-ID: <CACRpkdYUZQt+PTOf0+ReQFWgSjitXM-CXMUfVAiQsL3QxDTi5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 2:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> [Me]
>> And there are some non-bisectable patches due to the
>> driver in staging (which was put there because Synaptics would
>> submit another driver "real soon now" and that was something like
>> two years ago), so I might have to squash some of them together to one.
>
> What breaks bisection here? The "[PATCH 5/9] staging: ste_rmi4: kill
> platform_data hack" patch should be independent of everything else,
> it just touches more files than we'd like.

It includes <mach/irqs.h> that is removed by earlier patches, so
it stops compiling before this patch.

Yours,
Linus Walleij
