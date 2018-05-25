From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 25 May 2018 06:12:00 +0200
Subject: [PATCH v2 5/5] MAINTAINERS: Add Actions Semi S900 pinctrl entries
In-Reply-To: <CACRpkdYF7a-uwye0uwn-pT9Bprj74q1-Pcbq4WLyiE+kYY4j7w@mail.gmail.com>
References: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
 <20180520051736.4842-6-manivannan.sadhasivam@linaro.org>
 <CACRpkdYF7a-uwye0uwn-pT9Bprj74q1-Pcbq4WLyiE+kYY4j7w@mail.gmail.com>
Message-ID: <25d1c303-71d7-8c38-880f-7bb0e133a876@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.05.2018 um 10:40 schrieb Linus Walleij:
> On Sun, May 20, 2018 at 7:17 AM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
>> Add S900 pinctrl entries under ARCH_ACTIONS
>>
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Patch applied tentatively so we have some maintenance entry for this.
> 
> Andreas expressed concerns about the driver earlier, so he might want it
> split from the platform parts and have a separate entry for the pinctrl+GPIO
> so Manivannan can maintain that part, also it makes sense to list
> Manivannan as comaintainer of ARCH_ACTIONS with this in.
> 
> Andreas: how would you like to proceed?
> 
> I understand that I was a bit pushy or even rude in my last message
> about the maintenance of this platform and the code structure of
> the pin control driver. I am sorry if it caused any bad feelings on your
> side :( social conflicts give me the creeps, I just try my best. Maybe
> my best isn't always what it should be.

I fail to understand how splitting the MAINTAINERS section is going to
help with the pinctrl conflict at hand? The problem is that instead of
refactoring my S500 pinctrl driver to his liking, Mani has submitted a
competing S900 pinctrl driver that you went on to merge. The human
aspect is that merging his driver took the credit away from me having
written the earlier pinctrl driver (based on my rtd1295 pinctrl driver).
The practical aspect is that I can't drop my pinctrl driver from my work
branch until there is equivalent functionality in the merged driver. I
am lacking the time to rewrite S500 pin definitions on top of Mani's
myself at this time, and I haven't seen S500 patches from him yet.

Also I had been investing efforts in explaining the upstreaming process
to Actions, last in November. I see Thomas Liau and Jeff Chen missing in
CC and I have not seen any Reviewed-by or Acked-by from anyone at
Actions on this and the preceding series. There are more chips than the
one on Linaro's 96board, so I would prefer to assure that the design
works for all. Thus I am very critical of you applying the patches
without waiting for review by Actions.

Other aspects are: The reason I wrote the pinctrl driver is that I
experienced a UART TX issue on the Sparky board and was hoping a pinctrl
driver might resolve that, but it didn't. So I still have a mix of
boards where some are working and some are pretty unusable, without any
clues on why.

That said, I don't object to having a separate MAINTAINERS section for
the pinctrl driver(s) as long as I still get CC'ed on changes. We have
wanted to add Mani as R for Actions overall, so that would probably mean
adding me as R to an Actions pinctrl section, to avoid syncing the paths
between two sections. I had previously felt that it does not make sense
to list Mani as co-maintainer (M) for Actions overall since he can't tag
and submit from my repo. And for the record I have offered him to take
over which he didn't want to. I still hope to find some more time to
review and queue his SPS patches, a driver that I have designed and thus
understand and am much happier about the incremental additions there.

A further side note is that I had reached out about setting up an
infradead mailing list linux-actions, but there was no response from
David or anyone. Having an L on the section(s) would avoid messing with
R and hand-maintained CC lists. Any help with that appreciated.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
