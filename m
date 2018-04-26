From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Apr 2018 15:23:57 +0200
Subject: [dragonboard] [PATCH 1/1] dts: qcom: db820c: Add gpio-line-names
 property
In-Reply-To: <20180416100306.5f6bzkzlsx3ufvw7@mani>
References: <20180414031811.11351-1-manivannan.sadhasivam@linaro.org>
 <20180414031811.11351-2-manivannan.sadhasivam@linaro.org>
 <9acdd412-9b6d-ec63-c5ca-c5fa8d98d489@linaro.org>
 <20180416100306.5f6bzkzlsx3ufvw7@mani>
Message-ID: <CACRpkdZxwz5=oTxGWBgVHfy-D9s-f03qqjypUeJj6GrpXQcEcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 12:03 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Mon, Apr 16, 2018 at 11:48:59AM +0300, Todor Tomov wrote:

>> > + * When the 96Board naming of a line and the schematic name of
>> > + * the same line are in conflict, the 96Board specification
>> > + * takes precedence, which means that the external UART on the
>> > + * LSEC is named UART0 while the schematic and SoC names this
>> > + * UART3. This is only for the informational lines i.e. "[FOO]",
>>
>> It seems to me that this can lead to some confusion for cases when
>> some schematic names have 96board names and others don't. (An
>> example below.) However I don't really see any better way to do
>> it. I'm wondering whether adding the schematic name in
>> the comment (for gpios which are named with 96board names)
>> can help a little. What do you think? Or any other idea?
>>
>
> Specifying the schematic names in comments is a good idea!
>
> Linus: Do you have any suggestion here?

Go for this.

Generally ask the question: what does the user need?

In this case, especially userspace libraries like mriaa (right name?)
should be able to work out-of-the-box without knowing what
board it is but know it has a 96board connector.

Yours,
Linus Walleij
