From: amit.kachhap@gmail.com (amit kachhap)
Date: Wed, 23 Nov 2011 12:22:48 +0530
Subject: [PATCH V3 3/6] ARM: exynos: save L2 settings during bootup
In-Reply-To: <20111122094925.GV9581@n2100.arm.linux.org.uk>
References: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
 <1321954532-18724-4-git-send-email-amit.kachhap@linaro.org>
 <20111122094925.GV9581@n2100.arm.linux.org.uk>
Message-ID: <CADGdYn6HCbT23x+asqYo=fvc8z1-oaPGqXxZP793dVwx9NZ=xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 3:19 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 22, 2011 at 03:05:29PM +0530, Amit Daniel Kachhap wrote:
>> This patch adds code to save L2 register configuration at boot, and
>> later used to resume L2 before MMU is enabled in suspend and cpuidle
>> resume paths.
>
> Is there a reason exynos isn't using the generic l2 code?

Actually the generic l2 save/resume works fine for full l2 shutdown
but in case of l2 retention mode few registers need to be
re-initialised which is not handled in the generic code.(implemented
in file arch/arm/plat-s5p/sleep.S)

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
