From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 7 Dec 2017 17:30:48 +0800
Subject: [PATCH 2/9] ASoC: sun4i-i2s: Add compatibility with A64 codec I2S
In-Reply-To: <CAEKpxBnWYiSq-Xrzj9MET61kGyVSJZPNnWpDh8jwnmdtw=GKtA@mail.gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-3-anarsoul@gmail.com>
 <CAEKpxBmHhZ+2WNXJEPbQFS6KeKsqRrZeNodRnu1M5yLc15DerA@mail.gmail.com>
 <CA+E=qVd+uM0Aq_=sf+fomQ-m+3Oy0MdG7OPjF5tVagG1UgKYzg@mail.gmail.com>
 <CAEKpxBnWYiSq-Xrzj9MET61kGyVSJZPNnWpDh8jwnmdtw=GKtA@mail.gmail.com>
Message-ID: <CAGb2v67R76U0+JSS0yMDUCB52QXe=xbt8w=49sTn0TNTM8SccQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 5:21 PM, Code Kipper <codekipper@gmail.com> wrote:
> On 4 December 2017 at 08:34, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>> I'd keep it sun50i_a64_acodec_i2s, since other 3 I2S modules aren't
>> compatible with this one, but similar to H3.
>
> Well I wouldn't and the description of it is usage is clearly stated
> in the devicetree
> for the dai.
>>
>> On Sun, Dec 3, 2017 at 10:42 PM, Code Kipper <codekipper@gmail.com> wrote:
>>> On 3 December 2017 at 21:41, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>>>> From: Marcus Cooper <codekipper@gmail.com>
>>>>
>>>> The I2S block used for the audio codec in the A64 is very similar
>>>> to what is used by the A10(sun4i) devices. However, its TX FIFO is
>>>> located at a different address.
>>>>
>>>> [vasilykh: - added fixed_wss and wss_value to A64 quirks,
>>>>            - changed compatible to 'allwinner,sun50i-a64-acodec-i2s,
>>>>              since A64 has 3 more I2S blocks that are not compatible
>>>>              with audio codec I2S]
> This needs to be investigated more...I'm suspicious of the
> SUN8I_I2S_FMT0_LRCK_PERIOD value which is hardcoded to 0x1f.
> I've made this following change
> https://github.com/codekipper/linux-sunxi/commit/4c5fe5f5576cfbb2e1e94a99cd19dfdc9403ea50
> which seems to work for me but I would like to look at it with a logic
> analyser and test other sample depths.
> CK

Another good reason not to have hard-coded values for things that
are rightly configurable. :)

ChenYu
