From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 5 Aug 2014 09:18:13 +0800
Subject: [PATCH v16 2/9] ARM: hisi: enable MCPM implementation
In-Reply-To: <alpine.LFD.2.11.1408042101360.6061@knanqh.ubzr>
References: <1407121088-4151-1-git-send-email-haojian.zhuang@linaro.org>
 <1407121088-4151-3-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1408041741460.6061@knanqh.ubzr>
 <CAD6h2NTFJ0qBdymhQ1bEaKpCTQT13r2-F9HRDw9SdSS31Zer8w@mail.gmail.com>
 <alpine.LFD.2.11.1408042101360.6061@knanqh.ubzr>
Message-ID: <CAD6h2NSs7epwgtH29sjQ37nLZroLJK-+1aqY52JcUg8Y2fXcpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 August 2014 09:02, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 5 Aug 2014, Haojian Zhuang wrote:
>
>> On 5 August 2014 06:43, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > Sorry for the delay -- I was on vacation.
>> >
>> > On Mon, 4 Aug 2014, Haojian Zhuang wrote:
>> >
>> >> Multiple CPU clusters are used in Hisilicon HiP04 SoC. Now use MCPM
>> >> framework to manage power on HiP04 SoC.
>> >>
>> >> Changelog:
>> >> v16:
>> >>   * Parse bootwrapper parameters in command line instead.
>> >
>> > What is that about?  I don't particularly like to see bootloader
>> > handshake details passed to the kernel via the kernel command line
>> > mechanism.  Given this looks like special memory regions, can't they be
>> > specified via the device tree instead?
>> >
>>
>> Others don't agree put them into DTS file. So I move them into command line.
>
> Could you give me a pointer to the discussion around that please?
>
>
> Nicolas

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275944.html

Mark challenged what's relationship between bootwrapper address and
system controller. Actually code in bootwrapper is like trampoline.
And it's a software protocol, not hardware description. So I moved
them into command line instead.

Regards
Haojian
