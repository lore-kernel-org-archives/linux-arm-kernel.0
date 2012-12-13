From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 13 Dec 2012 11:22:24 +0100
Subject: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save
 power
In-Reply-To: <20121213101117.GF14363@n2100.arm.linux.org.uk>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD3B1@SC-VEXCH1.marvell.com>
 <CADz5_gJ70KrHL5NoSPQbFdeHnQxWLh87zq6N+-V7J7Yq7t+aPQ@mail.gmail.com>
 <CAPDyKFrt4zWmhyO-UJAFPOH=90n4OwRPv3nczr4jPGBnc_jT5w@mail.gmail.com>
 <20121213101117.GF14363@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFrkNnudy_rCL4P3GjRjh3zZ0aGVLti8uLJaW4FfuXm9JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2012 11:11, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 13, 2012 at 10:04:46AM +0100, Ulf Hansson wrote:
>> Anyway, this need to be thought of as future step, since this patch is
>> not changing anything to that sequence as Kevin also is pointing out.
>
> Given that Kevin is talking about stuff in sdhci as if it affects MMCI,
> and that neither of you have picked that up, you're *still* not gaining
> any confidence from me that you're actually thinking about the changes
> you're making.  So I'm not really caring about how many acks your patches
> get, I'm still going to be reluctant to apply them without thinking about
> them for a bit.

MMCI is doing "pm_runtime_get_sync" in it suspend. So the same
principles as Kevin is describing for sdhci goes for MMCI. Sorry if
this was not clearly pointed out.

Kind regards
Ulf Hansson
