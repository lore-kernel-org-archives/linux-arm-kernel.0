From: james.morse@arm.com (James Morse)
Date: Wed, 15 Jun 2016 11:25:18 +0100
Subject: [PATCH] PM / Hibernate: Don't let kasan instrument snapshot.c
In-Reply-To: <7230305.BYjCFel4WC@vostro.rjw.lan>
References: <1464870032-12289-1-git-send-email-james.morse@arm.com>
 <7230305.BYjCFel4WC@vostro.rjw.lan>
Message-ID: <57612D0E.5050209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 15/06/16 00:26, Rafael J. Wysocki wrote:
> Does the arch code need to be annotated in a similar way too?

Only if you do the restore copying from C, both 32bit and 64bit x86 do this copy
in assembly code, which doesn't get instrumented.


Thanks,

James
