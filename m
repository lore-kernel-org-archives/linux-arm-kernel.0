From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Jun 2013 09:45:14 +0100
Subject: [PATCH 1/9] dma: pl330: rip out broken, redundant ID probing
In-Reply-To: <CAJe_Zhc1UoTC4q4oaW=dzyi_10Q7EoezoT=G8_v+yCmBxV75+A@mail.gmail.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-2-git-send-email-will.deacon@arm.com>
 <CAJe_Zhc1UoTC4q4oaW=dzyi_10Q7EoezoT=G8_v+yCmBxV75+A@mail.gmail.com>
Message-ID: <20130611084514.GA24729@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 05:40:36AM +0100, Jassi Brar wrote:
> On 11 June 2013 00:04, Will Deacon <will.deacon@arm.com> wrote:
> > The PL330 driver probes the peripheral and primecell IDs of the device to
> > make sure that it is indeed an AMBA PL330. However, it does this by
> > making byte accesses to a device mapping of the word-aligned ID
> > registers, which is either UNPREDICTABLE or generates an alignment fault
> > (depending on the presence of the virtualisation extensions).
> >
> > Rather than fix this code, we can actually rip most of it out and let
> > the AMBA bus driver correctly do the probing for us.
> >
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

Thanks for the acks Jassi!

Will
