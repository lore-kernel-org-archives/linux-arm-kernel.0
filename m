From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 15 Oct 2010 17:25:07 +0300
Subject: [PATCH .36-rc8] arm: mm: allow, but warn, when issuing ioremap()
	on RAM
In-Reply-To: <1287152120-7201-1-git-send-email-felipe.contreras@gmail.com>
References: <1287152120-7201-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <AANLkTinjd6_X62XPAvHNK4Tf233yD0-LKBBe96CE8_T2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 15, 2010 at 5:15 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> Drivers have been relying on this behavior, but done so wrongly.
> However, rather than breaking drivers from .35 to .36, we should warn on
> .36 and only break on .37. This way we give a chance for contributors to
> fix the issues.
>
> According to ARM, the behavior of having multiple mappings is
> unspecified from ARMv6+. This causes real issues specially on modern
> hardware, and specially with speculative prefetching. So drivers need to
> be fixed.
>
> Also, since current hardware has palliative meassures to deal with
> multiple mappings with the same memory type but diferent cacheability
> attributes, ensure that such restriction is taking place.

Ah, disregard this, a similar one is on .36-rc8 already (06c1088), I
wasn't CC'ed.

-- 
Felipe Contreras
