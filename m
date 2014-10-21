From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 21 Oct 2014 14:52:49 +0200
Subject: [PATCH v4] ARM: perf: save/restore pmu registers in pm notifier
In-Reply-To: <20141020092005.GD4370@arm.com>
References: <6106CAF835F351419ADA79E4836E6EC71B6A53C826@SC-VEXCH4.marvell.com>
 <9034CBD80F070943B59700D7F8149ED9A0875730@SC-VEXCH4.marvell.com>
 <20140513184503.GF16388@arm.com>
 <9034CBD80F070943B59700D7F8149ED9A087573F@SC-VEXCH4.marvell.com>
 <537337F3.4080300@arm.com>
 <9034CBD80F070943B59700D7F8149ED9A0875776@SC-VEXCH4.marvell.com>
 <9034CBD80F070943B59700D7F8149ED90182308172@SC-VEXCH4.marvell.com>
 <20140703175706.GI17372@arm.com>
 <9034CBD80F070943B59700D7F8149ED9024EB81CD8@SC-VEXCH4.marvell.com>
 <5444D2E0.9070205@arm.com> <20141020092005.GD4370@arm.com>
Message-ID: <CANLsYkziaqnVkOGpnzEHLiS35JHc2Sd_yTz_ruWpwE=JMZyvxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 October 2014 11:20, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Oct 20, 2014 at 10:16:16AM +0100, Sudeep Holla wrote:
>> On 20/10/14 09:46, Neil Zhang wrote:
>> > Will, I prefer to check always-on field under PMU node to check
>> > whether we need Save/restore them.
>> >
>> But how do you handle it for different idle states. e.g. if CPU is in
>> retention, PMU's *might be* retained. Also I don't think PMUs will be
>> placed in "always-on" power domain like timers. So using "always-on"
>> sounds incorrect to me.
>
> Adding Mathieu to CC, since I spoke to him at LPC about this and he was
> talking about implementing proper PM domain descriptions for coresight
> components.
>
> Will

Will is correct - it's in the pipeline now.  Just hang tight.
