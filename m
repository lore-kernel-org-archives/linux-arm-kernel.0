From: jglauber@cavium.com (Jan Glauber)
Date: Wed, 28 Feb 2018 11:23:35 +0100
Subject: [PATCH -stable] arm64: mm: don't write garbage into TTBR1_EL1
 register
In-Reply-To: <20180226113050.GE8736@arm.com>
References: <20180223182902.24873-1-ard.biesheuvel@linaro.org>
 <20180224083424.GC9681@kroah.com>
 <CAKv+Gu9rZEAk1RMUEk=7XCVVkLQ-chDu7GTGArCG0YeYcmx52w@mail.gmail.com>
 <20180226113050.GE8736@arm.com>
Message-ID: <20180228102335.GA6619@wintermute>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 11:30:50AM +0000, Will Deacon wrote:
> Damnit, sorry again. I changed the argument order of phys_to_ttbr along
> the way, so must've confused myself during the backporting exercise. It's
> also one of those things that will lead to potential TLB corruption in rare
> circumstances where the junk in TTBR1 ends up giving a valid translation,
> so it didn't crop up in my testing. How did Nicolas see this? The bug
> report I saw didn't look related.

FWIW, we've been hitting this bug with a distribution backport on
ThunderX2 on every boot. Due to bad luck there was a non-zero value
in TTBR1 that crashed the kernel immediately and dropped us to firmware.

--Jan
