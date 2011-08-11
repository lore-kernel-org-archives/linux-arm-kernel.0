From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 11 Aug 2011 19:52:29 +0530
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <CAKnu2Mo=9wusKrc7DeL9fk-fq3pY1D3WKHXYmo+b9w5GbyzegA@mail.gmail.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
	<CABb+yY3SnqKN78U7vLbom1i00m=ThnRVQDVM_iX1TPu=+XzSNQ@mail.gmail.com>
	<20110810104025.GK1831@n2100.arm.linux.org.uk>
	<CABb+yY3=q5Nq1wtM6Av2DrgUfjZR_Ao40QhBhv_ik9naAd5wRg@mail.gmail.com>
	<CACRpkdaCyUJ3A9VWfsVuwJj3DGVkvjc2_ZOD4yM4YX3NPxAAYQ@mail.gmail.com>
	<CABb+yY2Usd5=RW6BV69UW=Tq0zQW6LCtT2GhfdHGA61ZU3aNcQ@mail.gmail.com>
	<CAKnu2Mo=9wusKrc7DeL9fk-fq3pY1D3WKHXYmo+b9w5GbyzegA@mail.gmail.com>
Message-ID: <CABb+yY0G_OeVgQs4ySVMQBcBh2q=nUhj+U+=tZG751WT9qRYuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2011 at 6:25 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/8/10 Jassi Brar <jassisinghbrar@gmail.com>:
>> On Wed, Aug 10, 2011 at 5:24 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>> Linus W, was there anything you said wouldn't work with the scheme ?
>>>> Please tell now on the record.
>>>
>>> It would *work* but the current proposal is *not elegant* IMO.
>>
>> would *work* ?-> You could find no case that the scheme wouldn't support.
>
> Well there is the usecase where we have a lot of devices, but it is
> true we don't have that kind of hardware around.
I am pissed off by Russell's allegation that
{
Linus had not agreed to your proposal and saw more or less the same
problems with it which I've been on at you about via your other email
alias/lkml.
}
whereas what you say now, and when we discussed, does not repeat a single
concern of his!
You never say/said what 'problem' do you see.

Russell has been skeptical if my idea would work at all for his
versatile setups.
While you say it would *work* but you just want the idea implemented
using device pointer and strings !

Btw, do bring on any esoteric setup that you have in mind even if you never
expect to have it in real.

I am not married to my idea. I don't wanna push any further if it wouldn't work.

The biggest challenge I see is the huge modification needed. Not some
weird setup !

>> Client having to specify the device it wants a channel for, is a
>> waste - otherwise we don't fully get rid of platform assistance for
>> channel selection!
>
> I think I saw you proposal define REQ(MMC,2) for example,
> isn't that specifying the device?
Not using platform provided device pointers, but by using globally
defined values. (See my last reply to Vinod's setup
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060860.html)

The notion of "must-use" device pointer sucks!
More so when we can have simpler and at least as good implementation
without using them !

Do you have any reason for using device pointer and strings, other
than just "because clock and regulator use them" ??

>>> rxc = dma_request_slave_channel(dev, "MMC-RX");
>>> txc = dma_request_slave_channel(dev, "MMC-TX");
>>
>> Absolutely "not-very-good" !
>> We can do without the 'dev' argument.
>
> You still need to pass in something referring you back to
> the device.
Nopes. As I said please see my reply to Vinod's setup.


>> Do you propose to implement a string parser in the core ?!
>
> Yes, the clock and regulator framework already does that.
> But it is only used when you cannot pass in a struct device *
> directly, like from device tree.
Dude, I have utter disrespect for using strings in a case such as
expressing requirements.
I have already explained how we can easily and in a _better_ way
do without them (again see my last reply to Vindo's setup).
Tell me 1 reason why using strings, in this case, would be better ?
