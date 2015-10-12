From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 12 Oct 2015 18:01:25 +0100
Subject: [PATCH v2 07/22] arm64: Keep track of CPU feature registers
In-Reply-To: <20151008150346.GK17192@e104818-lin.cambridge.arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-8-git-send-email-suzuki.poulose@arm.com>
 <20151007171621.GD17192@e104818-lin.cambridge.arm.com>
 <56163D7F.4000003@arm.com>
 <20151008150346.GK17192@e104818-lin.cambridge.arm.com>
Message-ID: <561BE765.1080409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/15 16:03, Catalin Marinas wrote:
> On Thu, Oct 08, 2015 at 10:55:11AM +0100, Suzuki K. Poulose wrote:

...
>
> So we have three types of fields in these registers:
>
> a) features defined but not something we care about in Linux
> b) reserved fields
> c) features important to Linux
>
> I guess for (a), Linux may not even care if they don't match (though we
> need to be careful which fields we ignore). As for (b), even if they
> differ, since we don't know the meaning at this point, I think we should
> just ignore them. If, for example, they add a feature that Linux doesn't
> care about, they practically fall under the (a) category.
>
> Regarding exposing reserved CPUID fields to user, I assume we would
> always return 0.

Mark,

Do you have any comments on this ? The list I have here is what you came
up with in SANITY checks.

Thanks
Suzuki
