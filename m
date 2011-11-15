From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 15 Nov 2011 13:21:07 +0530
Subject: [PATCH 1/4] ARM: PL330: Don't call the callbacks if there isn't
 any active transfer
In-Reply-To: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
References: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
Message-ID: <CAJe_Zhf+PAeM+wquQykXNDG74Nc+jQNXrp+RLMKSySCNPum8Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 November 2011 20:00, Javi Merino <javi.merino@arm.com> wrote:
> If there are no transactions running it is not only wrong but
> potentially dangerous to call the callbacks.
>
The idea was to have dmac drivers not touch the xfer after it has been submitted
and before the callback is made upon successful transmission or abort/flush.

> There can be a stale struct pl330_req pointer from a previous run, but the
> memory may be free already.
>
Sorry I am unable to fathom the scenario. The pl330_request_channel resets
both pl330_req pointers. Maybe some real failure you saw, could help
me understand.
Thnx.
