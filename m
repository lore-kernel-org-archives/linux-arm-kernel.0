From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Feb 2014 18:12:31 +0000
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <B1132DDA-ECB1-4971-98AE-6DDDDD985CFB@codeaurora.org>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <1392100183-30930-3-git-send-email-kgene.kim@samsung.com>
 <CAOesGMiWsWXkQkb-_VZGco0gKNZPsHf3ubR88y4Pt4-umk5_Ww@mail.gmail.com>
 <20140212103824.GF29702@arm.com>
 <B1132DDA-ECB1-4971-98AE-6DDDDD985CFB@codeaurora.org>
Message-ID: <1540B9A3-2485-4149-81DD-7D86A532E5D4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 Feb 2014, at 16:25, Kumar Gala <galak@codeaurora.org> wrote:
> On Feb 12, 2014, at 4:38 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
>> On Tue, Feb 11, 2014 at 11:39:27PM +0000, Olof Johansson wrote:
>>> On Mon, Feb 10, 2014 at 10:29 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>>> This patch adds support for Samsung GH7 SoC in arm64/Kconfig.
>>>> 
>>>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> 
>>> The overhead of building one more device tree isn't very large, and I
>>> don't see any other need to have a Kconfig entry per SoC at this time.
>>> It's of course up to Catalin, but you might just want to always
>>> compile all dts files instead.
>> 
>> For arm64, I thought of getting rid of ARCH_* Kconfig entries entirely,
>> only that I haven't heard any strong opinion either way (in which case
>> I'll do it, with a risk of single Image getting bigger and bigger and
>> people needing smaller Image can trim their .config).
> 
> One reason to keep around ARCH_* is for drivers shared between arm and arm64 that depend on it.

We already converted some of them (those depending on ARCH_VEXPRESS) to
just depend on ARM64. Ideally, at some point I?d like to see them as
defaulting to modules but I don?t think we are there yet (we had some
discussions at the last KS, I?m not sure anyone started looking into
this).
