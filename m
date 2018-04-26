From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Apr 2018 14:49:44 +0200
Subject: [PATCH 1/5] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
In-Reply-To: <20180416181940.4b5z4svbde3ompij@rob-hp-laptop>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
 <1523440025-18077-2-git-send-email-amelie.delaunay@st.com>
 <20180416181940.4b5z4svbde3ompij@rob-hp-laptop>
Message-ID: <CACRpkdYOMjjYyWQz7PK34jqUK7z5-CmH1HY6un4k8nBn7Cq8ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 8:19 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Apr 11, 2018 at 11:47:01AM +0200, Amelie Delaunay wrote:
>> This patch adds documentation of device tree bindings for the
>> STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

>> +     stmfxpinctrl: stmfx at 42 {
>> +             compatible = "st,stmfx-0300";
>> +             reg = <0x42>;
>> +             interrupt-parent = <&gpioi>;
>> +             interrupts = <8 IRQ_TYPE_EDGE_RISING>;
>> +             vdd-supply = <&v3v3>;
>> +             status = "okay";
>
> Don't show status in examples.
>
>> +
>> +             stmfxgpio: gpio {
>
> Why does this need to be a sub node? Are there functions beyond GPIO?

Amelie can answer to whether there are, I suspect there
are and in the review of patch 2 I suggest a MFD parent
and parent/child spawning of a MFD child for the GPIO
and pin control device.

Yours,
Linus Walleij
