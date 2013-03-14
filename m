From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Mar 2013 16:28:09 +0900
Subject: [PATCH 00/04] ARM: shmobile: r8a73a4 SoC and APE6EVM board support
In-Reply-To: <201303121228.31067.arnd@arndb.de>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <201303121228.31067.arnd@arndb.de>
Message-ID: <CANqRtoQeSqZas7Zdyz-de13_4W_a5P6_xrh_23nKZzZV47xF_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 9:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 12 March 2013, Magnus Damm wrote:
>> ARM: shmobile: r8a73a4 SoC and APE6EVM board support
>>
>> [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support
>> [PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support
>> [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support
>> [PATCH 04/04] ARM: shmobile: APE6EVM support
>>
>> This series adds initial support for r8a73a4 and APE6EVM. The SoC
>> is known as r8a73a4 which is built around Cortex-A15 and makes use
>> of SCIF for serial and IRQC interrupt controller for external IRQs.
>>
>> This initial SoC and board support is providing limited DT-only
>> support and a very basic C-version of board support. In the future
>> improved PINCTRL and clock framework support will be added, followed
>> by SMP support.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Patches look good so far. I assume you have made them in a way that lets
> you easily keep around non-DT support internally, right?

Thanks. Regarding your question, please allow me try to answer a
rather simple question in a complicated way. =)

I have some perhaps naive hope of not having to force people to write
out of tree code. I believe it is possible to use upstream to deliver
something short term and at the same time work with upstream towards
long term goals. So I hope we won't be forced to keep non-DT support
around internally.

For short term, in some cases where we don't have complete DT bindings
(like clocks and pinctrl at the moment) we still have to use board
code written in C to configure the hardware. Using DT only at this
point would result in a non-working kernel without support for
mandatory components like pinmux, clock support and power domains, so
for short term that doesn't fly.

As I know you've seen, we are actively working on improving our DT
coverage. Our approach to DT so far is to work our way towards more
complete support in the -reference DT board support code. We keep the
C version around as feature complete implementation and when the
-reference DT version of the board code is good enough then we kill
the C version and use DT only.

These patches for new SoCs and boards use a mix of DT and C. In
practice that means that I plan on using platform devices and DT in
parallel. These platform devices can easily go away upon your request,
if so a new version of the patch will be submitted with the offensive
hunks removed. The old version may however still be used for back
porting.

So if there are some portions of the code that you would like me to
rework then please let me know and I will do my best to follow your
guidance. I am also open to clean up various portions of the code if
you have some particular place that you feel needs extra attention.

Thanks for your help,

/ magnus
