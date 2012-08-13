From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 13 Aug 2012 19:37:54 +0200
Subject: [PATCH] ARM: at91: fix drivers broken because of sparse irq
 support
In-Reply-To: <1344872334-1532-2-git-send-email-ludovic.desroches@atmel.com>
References: <1344872334-1532-1-git-send-email-ludovic.desroches@atmel.com>
 <1344872334-1532-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CAGhQ9Vw_CvC71n=9Pr6SY0qsSmFVFTn76BVRbh64RP80G6pyZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

On Mon, Aug 13, 2012 at 5:38 PM,  <ludovic.desroches@atmel.com> wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Some drivers directly use AT91_ID_SYS as virq so they are broken because of
> the NR_IRQS_LEGACY virq offset introduced with sparse irq support.

This patch makes my board boot again. Thanks.

Feel free to add;
Tested-by: Joachim Eastwood <joachim.eastwood@jotron.com>

> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: stable at vger.kernel.org

Why are you sending this to stable?
This is a regression only in 3.6 and should go upstream ASAP.

regards
Joachim Eastwood
