From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 11 Mar 2016 10:45:55 +0700
Subject: [PATCH v1 2/3] mailbox: rockchip: Add Rockchip mailbox driver
In-Reply-To: <3952968.vXrbfbrlZ2@diego>
References: <1445931106-683-1-git-send-email-wxt@rock-chips.com>
 <1445931106-683-3-git-send-email-wxt@rock-chips.com>
 <3952968.vXrbfbrlZ2@diego>
Message-ID: <CABb+yY2ZJk-oP20K12qv9YQggQJdGqCWrgMiTyuL+O92eQyR7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 8, 2016 at 1:48 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Jassi,
>
> Am Dienstag, 27. Oktober 2015, 15:31:45 schrieb Caesar Wang:
>> This driver is found on RK3368 SoCs.
>>
>> The Mailbox module is a simple APB peripheral that allows both
>> the Cortex-A53 MCU system to communicate by writing operation to
>> generate interrupt.
>> The registers are accessible by both CPU via APB interface.
>>
>> The Mailbox has the following main features:
>>
>> 1) Support dual-core system: Cortex-A53 and MCU.
>> 2) Support APB interface.
>> 3) Support four mailbox elements, each element includes one data word,
>>    one command word register and one flag bit that can represent
>>    one interrupt.
>> 4) Four interrupts to Cortex-A53.
>> 5) Four interrupts to MCU.
>> 6) Provide 32 lock registers for software to use to indicate whether
>>    mailbox is occupied.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>
> it seems this patch has fallen through the cracks. Could you take a look if it
> needs anything else?
>
The 0Day kbuild test robot had reported an error in the 3rd patch. I
was expecting another revision. Though that patch shouldn't go via
mailbox tree, so I am picking up the first two patches with a minor
change that is removing the unused variable 'buf_base'.

Thanks.
