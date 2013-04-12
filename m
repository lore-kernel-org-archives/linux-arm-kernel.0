From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 12 Apr 2013 14:40:39 +0100
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <51680AF9.7040109@arm.com>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
Message-ID: <CAFEAcA-1HAG0pY-j-rqU=QmSoep3Di-KNPATvuou8ghRn3SaqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 April 2013 14:24, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Nak. The fact that one of the CPUs seem to hang is a sure sign that
> something is severely broken, and you definitely want to fix that issue,
> instead of blindly ignoring it.
>
> Additionally, it seems you're just papering over the issue. You should
> be able to exclude the A7 processors, but not completely deny KVM from
> running on the hardware.

Well that might be nice, as would fully supporting big.LITTLE
systems. But until somebody actually does that work it seems
like a better idea to fail gracefully rather than having a 50%
chance of failing gracefully and a 50% chance of going weird.

-- PMM
