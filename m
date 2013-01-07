From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 7 Jan 2013 15:20:08 +0100
Subject: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save
 power
In-Reply-To: <CADz5_gJ+8D_vm8SnfsnbheFpwarAxGSmY27FW_cvc7YdDH9pow@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD3B1@SC-VEXCH1.marvell.com>
 <CADz5_gJ70KrHL5NoSPQbFdeHnQxWLh87zq6N+-V7J7Yq7t+aPQ@mail.gmail.com>
 <CAPDyKFrt4zWmhyO-UJAFPOH=90n4OwRPv3nczr4jPGBnc_jT5w@mail.gmail.com>
 <20121213101117.GF14363@n2100.arm.linux.org.uk>
 <CAPDyKFrkNnudy_rCL4P3GjRjh3zZ0aGVLti8uLJaW4FfuXm9JQ@mail.gmail.com>
 <CADz5_gJ+8D_vm8SnfsnbheFpwarAxGSmY27FW_cvc7YdDH9pow@mail.gmail.com>
Message-ID: <CAPDyKFrW7Qcykzp837_iPXU-u8Jb7MpMrGNaHZM2-Q_tNfQ6jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2012 12:45, Kevin Liu <keyuan.liu@gmail.com> wrote:
> 2012/12/13 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 13 December 2012 11:11, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Thu, Dec 13, 2012 at 10:04:46AM +0100, Ulf Hansson wrote:
>>>> Anyway, this need to be thought of as future step, since this patch is
>>>> not changing anything to that sequence as Kevin also is pointing out.
>>>
>>> Given that Kevin is talking about stuff in sdhci as if it affects MMCI,
>>> and that neither of you have picked that up, you're *still* not gaining
>>> any confidence from me that you're actually thinking about the changes
>>> you're making.  So I'm not really caring about how many acks your patches
>>> get, I'm still going to be reluctant to apply them without thinking about
>>> them for a bit.
>>
>> MMCI is doing "pm_runtime_get_sync" in it suspend. So the same
>> principles as Kevin is describing for sdhci goes for MMCI. Sorry if
>> this was not clearly pointed out.
>>
> sorry for my unclear words. I just use sdhci directly to explain this.
> It's similar for sdhci and mmci on this point. pm_runtime is
> temporarily disabled during suspend/resume.
>
> Thanks
> Kevin

Russell, is this enough for convincing you that everything has been
thought of in this patch? Can we merge this?

Kind regards
Ulf Hansson
