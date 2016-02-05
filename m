From: k@japko.eu (Krzysztof Adamski)
Date: Fri, 5 Feb 2016 14:43:18 +0100
Subject: [PATCH v2] pinctrl: sunxi: H3 requires irq_read_needs_mux
In-Reply-To: <CACRpkdbVtLYRku03bbnT=f7Ex1FoJqBv4Z6nY7pWkHy6wvHUfg@mail.gmail.com>
References: <20160203075713.GA23312@box2.japko.eu>
 <CACRpkdbVtLYRku03bbnT=f7Ex1FoJqBv4Z6nY7pWkHy6wvHUfg@mail.gmail.com>
Message-ID: <20160205134317.GE12071@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 02:39:23PM +0100, Linus Walleij wrote:
>On Wed, Feb 3, 2016 at 8:57 AM, Krzysztof Adamski <k@japko.eu> wrote:
>
>> It seems that on H3, just like on A10, when GPIOs are configured as
>> external interrupt data registers does not contain their value.  When
>> value is read, GPIO function must be temporary switched to input for
>> reads.
>>
>> Signed-off-by: Krzysztof Adamski <k@japko.eu>
>
>2. Is this a regression that need to go in to fixes?

Not sure what you mean by that. H3 support was added recently without 
this flag so it never worked properly on this SoC.  With this patch it 
does. So it's just a normal bug fix, not a regression.

Best regards,
Krzysztof Adamski
