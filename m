From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 4 Jul 2016 20:55:50 +0530
Subject: [RFC PATCH v2 1/9] mailbox: Add Amlogic Meson
 Message-Handling-Unit
In-Reply-To: <CABb+yY3mD3chLtM02a5NvOO_HF2JAeu-SELkxzTxkkf5i+Bftg@mail.gmail.com>
References: <1466503374-28841-1-git-send-email-narmstrong@baylibre.com>
 <1466503374-28841-2-git-send-email-narmstrong@baylibre.com>
 <CABb+yY3r3_B9wbW6D-do8h8xMKCANQWfz1gFGyre1oWadd7A8Q@mail.gmail.com>
 <576C045A.3070701@baylibre.com>
 <CABb+yY0Oa7TNHsnt1HRAz1NUQ1QA_gR0-B-ki6qkuT332CnrmQ@mail.gmail.com>
 <57728319.5060701@baylibre.com>
 <CABb+yY3mD3chLtM02a5NvOO_HF2JAeu-SELkxzTxkkf5i+Bftg@mail.gmail.com>
Message-ID: <CABb+yY0Wnqz9sHq5cq-HM0PnaoQEGZD4h3OFTrxNXFY-v5g_4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 8:36 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Tue, Jun 28, 2016 at 7:30 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

>>
>> My main question is : do you really want to transform this simple driver into
>> a dirty multi-bus generic mailbox driver ?
>> The meson_mhu is only 199 lines and this patch adds 181 lines to the arm_mhu driver.
>>
>> I'll personally push to have two separate drivers here.
>>
> It is a shame if we need to copy a driver only due to changed register
> offsets. Let me give it a shot and see how worse off we would be.
>
OK, so I trimmed the differences further but it still doesn't look any
better. The best approach seems to be have a separate driver but with
consideration that its a 3rd party IP and hence likely to be used by
other platforms. That is, call it something meson-neutral. I will make
a few comments on the patch post.

Thanks
