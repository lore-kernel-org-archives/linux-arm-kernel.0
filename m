From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Jun 2013 16:54:23 -0600
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <1370469574.18839.33.camel@localhost>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <CAKON4OxDD5orX2w-_+d5kawTGXbE3KKj2QLERo9m7=NiUSXhgQ@mail.gmail.com>
 <51AFA6DD.3000202@wwwdotorg.org>
 <CAPweEDz=hFxXW3XF9CSNZpEFSjayb5an1E8Xze1_uQcCZONVxg@mail.gmail.com>
 <1370469574.18839.33.camel@localhost>
Message-ID: <51AFC19F.9040601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 03:59 PM, Henrik Nordstr?m wrote:
> ons 2013-06-05 klockan 22:24 +0100 skrev Luke Kenneth Casson Leighton:
...
>>  so the point is: if anyone wishes me to propose to allwinner that
>> they convert over to devicetree, or any other proposal which involves
>> significant low-level changes to their working practices that could
>> potentially have a massive knock-on effect onto their
>> multi-million-dollar clients, it had better be a damn good story.
> 
> Calm down. It isn't really a significant difference to them outside of
> the kernel. They do not need to change any of their configuraiton
> methods, only a small toolchain change in how the resultig images are
> built to have a corresponding device tree built.

If U-Boot needs to be parametrized, there are in theory a few options open:

1) Put all the parameters in the U-Boot configuration header. This is
normal.

2) Read some data structure at run-time. This data structure could in
theory be some SoC-specific blob format (e.g. the packed version of
information that some tool extracts from FEX/DT), a whole FEX blob, or
device tree. The U-Boot maintainers have already indicated that they
won't accept the first two options; run-time configuration has to be via
DT, and not via some SoC-specific mechanism. (As I found out to my
detriment when I attempted to make U-Boot on Tegra determine which UART
to use for debug at run-time by reading the configuration header that
our boot ROM uses). Now of course, boot0/boot1 could always transform
whatever data structure they wish into a DTB before passing that to
U-Boot...
