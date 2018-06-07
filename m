From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Jun 2018 17:02:03 +0100
Subject: [PATCH] perf: xgene: Fix IOB SLOW PMU parser error
In-Reply-To: <1528319214-19726-1-git-send-email-hoan.tran@amperecomputing.com>
References: <1528319214-19726-1-git-send-email-hoan.tran@amperecomputing.com>
Message-ID: <20180607160202.GA16435@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2018 at 02:06:54PM -0700, Hoan Tran wrote:
> This patch fixes the below parser error of the IOB SLOW PMU.
> 
>         # perf stat -a -e iob-slow0/cycle-count/ sleep 1
>         evenf syntax error: 'iob-slow0/cycle-count/'
>                                  \___ parser error
> 
> It replaces the "-" character by "_" character inside the PMU name.
> 
> Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>

Hmm, why did you only notice this now? :(

Anyway, whilst this could in theory break something, we did this for the CPU
PMUs in the past without issues so I'll pick this up.

Cheers,

Will
