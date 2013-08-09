From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 9 Aug 2013 16:41:57 +0800
Subject: [alsa-devel] [PATCH 1/3] ASoC: bt-sco: enable OF support
In-Reply-To: <20130807144628.GC6427@sirena.org.uk>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
 <20130717094718.GE22506@sirena.org.uk>
 <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
 <20130806170430.GL6427@sirena.org.uk>
 <CAGsJ_4xhkdNTKr6KBPMMPVfi7+NP+WHq2+_V545An6J+c6E7ug@mail.gmail.com>
 <20130807144628.GC6427@sirena.org.uk>
Message-ID: <CAGsJ_4y1JoPtXinAvaohDQF_4+DizNYh1jy+iYymypgeZfapKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/7 Mark Brown <broonie@kernel.org>:
> On Wed, Aug 07, 2013 at 03:59:46PM +0800, Barry Song wrote:
>
>> For 1, what kind of codes will have in the codec driver if adding a
>> link to UART in codec dts node? UART is very generic to transfer path.
>> it even doesn't know bluetooth is running on top of it.
>
>> For 2, if the case is that we add codec subnode in UART node,  the
>> UART driver will need to walk child nodes and extend platform device
>> for them, it seems it is not uart driver likes.
>
> I don't know what 1 and 2 are (they weren't numbered in the mail you're
> replying to)...  I'd expect that any intelligence would go into
> frameworks or into the device for the BT so for example if the BT device
> was hanging off the UART then the kernel would have generic support for
> parsing the DT and knowing that a fixed device was connected to the UART
> and be able to handle that - AIUI line disciplines are often used for
> this stuff.

it is fine. but it seems we are not easy to achieve this goal as we
actually want to do that at uart or tty core instead of specific uart
driver instance.

-barry
