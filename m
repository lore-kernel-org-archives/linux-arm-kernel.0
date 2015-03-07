From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 7 Mar 2015 10:06:21 +0100
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <CAJZ5v0h8vn26BeWPVhC4e_KNhBu15-mshnbq0K=OQ1M36vPQEQ@mail.gmail.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150304183809.GD22156@leverpostej>
 <14143668.0aRkeVrc3Q@vostro.rjw.lan>
 <20150305105729.GB13617@leverpostej>
 <CAJZ5v0h8vn26BeWPVhC4e_KNhBu15-mshnbq0K=OQ1M36vPQEQ@mail.gmail.com>
Message-ID: <20150307090621.GL23367@worktop.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 04:10:16PM +0100, Rafael J. Wysocki wrote:
> enable_irq_wake() has no effect on IRQF_NO_SUSPEND interrupts, so if the
> driver uses IRQF_NO_SUSPEND, it does not need to use enable_irq_wake()
> in addition to that.

I still feel we should BUG when someone is calling enable_irq_wake() on
an irq with only one desc which has NO_SUSPEND set.
