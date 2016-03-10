From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 10 Mar 2016 14:30:39 +0000
Subject: [PATCH 6/8] efi/arm*: libstub: wire up GOP handling into the ARM
 UEFI stub
In-Reply-To: <CAKv+Gu8hTSbZVgGj6epquwf6kkSJV+imAFvNobowFVtB5AUe2Q@mail.gmail.com>
References: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
 <1457588408-19309-7-git-send-email-ard.biesheuvel@linaro.org>
 <20160310082522.GB8618@gmail.com>
 <CAKv+Gu8hTSbZVgGj6epquwf6kkSJV+imAFvNobowFVtB5AUe2Q@mail.gmail.com>
Message-ID: <20160310143039.GF15775@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Mar, at 03:36:24PM, Ard Biesheuvel wrote:
> 
> Thank you. I am perfectly happy exercising some more caution here,
> though, considering that our past experiences involving reshuffling
> stub code for x86 were not a huge success (and broke Linus's laptop,
> among others')
> 
> I was very careful not to introduce cross-object data symbol
> references (which were the culprit before), and I tested both i386 and
> x86_64 to the extent feasible to me, but we'd need to confirm that
> those things are still fully correct before queuing this.

I agree 100% with Ard. It's far too late in the development cycle to
be introducing cross-architecture changes, and in particular, changes
to the code driving the early boot console.

I haven't reviewed the patches yet, but this is all v4.7 material.
