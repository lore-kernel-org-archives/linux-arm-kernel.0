From: anup@brainfault.org (Anup Patel)
Date: Tue, 1 Apr 2014 09:41:13 +0530
Subject: [PATCH v6 02/12] ARM/ARM64: KVM: Add common header for PSCI
 related defines
In-Reply-To: <CAJ5Y-ebjR3zdYrDx2HReXeCG2wSYwVgBXBdezjoQFKFmOcj7YA@mail.gmail.com>
References: <1396262773-7723-1-git-send-email-anup.patel@linaro.org>
 <1396262773-7723-3-git-send-email-anup.patel@linaro.org>
 <20140331180722.GD4756@lvm>
 <CAJ5Y-eaGsM4Moz815P7QM=7qh87RyzU-MVyeLOT64CLEaR0HQA@mail.gmail.com>
 <20140331183629.GF4756@lvm>
 <CAJ5Y-eb=JFtHWgLpxxm+L8z0w92GjBcJyUo8hWj6ik6GoakrtQ@mail.gmail.com>
 <CAJ5Y-ebjR3zdYrDx2HReXeCG2wSYwVgBXBdezjoQFKFmOcj7YA@mail.gmail.com>
Message-ID: <CAAhSdy1W0ExSnu1ROtkiiJUgwavk+wG0w_C-yME1tas7dtbNhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ashwin,

On Tue, Apr 1, 2014 at 1:13 AM, Ashwin Chaugule
<ashwin.chaugule@linaro.org> wrote:
> On 31 March 2014 15:26, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
>> Hi Christoffer,
>>
>> On 31 March 2014 14:36, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>>
>>>>
>>> I think Marc brought up the point previously that we may get to PSCI
>>> spec v42.17 and the defines should perhaps encompass the version we are
>>> defining things for right now...
>>>
>>> That being said, assuming new spec versions don't break backwards
>>> compatibility in the numbering, the wording proposed by your patch does
>>> look simpler.
>>>
>>> I do like the hardcoded IDs because that's how it's presented in the
>>> spec itself.
>>
>> Cool. I'll just add the following line in kbuild to this patch and resend.
>
> by "this" patch, I  meant my version. Sorry if I caused any confusion. :)
>
>>
>>  include/uapi/linux/Kbuild |    1 +
>>
>> +header-y += psci.h
>>
>> Meanwhile, if there are any strong preferences to using the uapi
>> header in Anup's patch, then I can rebase later.

Yes, the only difference between headers introduced by your patch
and this patch would be styling.

I was thinking of quickly revising this patch with following changes
pickedup from your patch:

+#define PSCI_POWER_STATE_ID_MASK 0xffff
+#define PSCI_POWER_STATE_ID_SHIFT 0
+#define PSCI_POWER_STATE_TYPE_MASK 0x1
+#define PSCI_POWER_STATE_TYPE_SHIFT 16
+#define PSCI_POWER_STATE_AFFL_MASK 0x3
+#define PSCI_POWER_STATE_AFFL_SHIFT 24
+
+#define PSCI_VER_MAJOR_MASK 0xffff0000
+#define PSCI_VER_MINOR_MASK 0x0000ffff
+#define PSCI_VER_MAJOR_SHIFT 16
+#define PSCI_VER_MAJOR(ver) \
+ ((ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT)
+#define PSCI_VER_MINOR(ver) (ver & PSCI_VER_MINOR_MASK)

We also have another RFC v2 patchset for QEMU side changes (being
tested currently) which uses the PSCI defines introduced by this patch.

It would be very helpful if you could rebase your patch with v7 of this
patch which will include some changes from your patch.
(Does this sound OK to you?)

Regards,
Anup

>>
>> Thanks,
>> Ashwin
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
