From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 1 Oct 2015 09:43:41 +0800
Subject: [PATCH] arm64: dts: add all hi6220 uart nodes
In-Reply-To: <CAL_JsqLSDXGCush7TMavRkw5F=vbBbrFaexFyBdXHyrfNVGjXg@mail.gmail.com>
References: <1443558552-5734-1-git-send-email-tyler.baker@linaro.org>
 <1459065.BtzC7pyUYF@wuerfel> <20150930173145.GG15635@sirena.org.uk>
 <CANMBJr7yY1PJChnFSRknqfOLORuWZSEONV+e=M=9heX3i-ADKA@mail.gmail.com>
 <CAL_JsqLSDXGCush7TMavRkw5F=vbBbrFaexFyBdXHyrfNVGjXg@mail.gmail.com>
Message-ID: <CAN1soZyKEFd6aqcDuttf6VwS7v2f+R9N1V5bAacUOeMHMt+dUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 1, 2015 at 3:03 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Sep 30, 2015 at 1:12 PM, Tyler Baker <tyler.baker@linaro.org> wrote:
>> On 30 September 2015 at 10:31, Mark Brown <broonie@kernel.org> wrote:
>>> On Wed, Sep 30, 2015 at 10:24:56AM +0200, Arnd Bergmann wrote:
>>>> On Tuesday 29 September 2015 13:29:12 Tyler Baker wrote:
>>>
>>>> >         aliases {
>>>> >                 serial0 = &uart0;
>>>> > +               serial1 = &uart1;
>>>> > +               serial2 = &uart2;
>>>> > +               serial3 = &uart3;
>>>> > +               serial4 = &uart4;
>>>> >         };
>>>
>>>> In the changelog you mention "both uarts", but here you have five of them.
>>>> Are they all accessible on the connector? If not, only provide aliases
>>>> for the ones that are, using numbering that makes most sense for given
>>>> how one would use the board.
>>
>> Thanks for the comment Arnd. Mark's comment below is correct, there
>> are only two UARTs accessible on the LS connection in addition to the
>> one on the board (solder pad).
>>
>> Is the following definition any clearer?
>>
>> serial0 = &uart0; // Onboard UART0
>> serial1 = &uart2; // LS expansion UART0
>> serial2 = &uart3; // LS expansion UART1
>
> Yes, but use C style comments.
>
> What about the BT UART?
>

Yes, all four uarts are used in hikey board. uar0 is onboard serial
uart. uart1 is
BT uart. uart2 & uart3 are connected to low speed expansion board. So Tyler
shouldn't decrease any uart from his current patch.
