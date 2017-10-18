From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Oct 2017 12:11:36 +0100
Subject: [PATCH v4 11/13] firmware: arm_sdei: add support for CPU private
 events
In-Reply-To: <20171017174432.1684-12-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
 <20171017174432.1684-12-james.morse@arm.com>
Message-ID: <20171018111135.rnywke6zfyjsibcv@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 06:44:30PM +0100, James Morse wrote:
> Private SDE events are per-cpu, and need to be registered and enabled
> on each CPU.
> 
> Hide this detail from the caller by adapting our {,un}register and
> {en,dis}able calls to send an IPI to each CPU if the event is private.
> 
> CPU private events are unregistered when the CPU is powered-off, and
> re-registered when the CPU is brought back online. This saves bringing
> secondary cores back online to call private_reset() on shutdown, kexec
> and resume from hibernate.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
