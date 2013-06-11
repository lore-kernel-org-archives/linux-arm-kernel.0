From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 11 Jun 2013 10:10:36 +0530
Subject: [PATCH 1/9] dma: pl330: rip out broken, redundant ID probing
In-Reply-To: <1370889285-22799-2-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-2-git-send-email-will.deacon@arm.com>
Message-ID: <CAJe_Zhc1UoTC4q4oaW=dzyi_10Q7EoezoT=G8_v+yCmBxV75+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 June 2013 00:04, Will Deacon <will.deacon@arm.com> wrote:
> The PL330 driver probes the peripheral and primecell IDs of the device to
> make sure that it is indeed an AMBA PL330. However, it does this by
> making byte accesses to a device mapping of the word-aligned ID
> registers, which is either UNPREDICTABLE or generates an alignment fault
> (depending on the presence of the virtualisation extensions).
>
> Rather than fix this code, we can actually rip most of it out and let
> the AMBA bus driver correctly do the probing for us.
>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
