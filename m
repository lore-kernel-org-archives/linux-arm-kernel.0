From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 10 Aug 2011 15:39:28 +0530
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <4E424F7B.2000800@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
Message-ID: <CABb+yY0Qvuhrn+FUhWDHMwUjv=nR4MOfLeDfTzG17HXEuu2pmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 2:59 PM, viresh kumar <viresh.kumar@st.com> wrote:
> On 08/10/2011 02:30 PM, Russell King - ARM Linux wrote:
>>> > They must be allocated when they are required and must be freed after we are
>>> > done with transfers. So that they can be used by other users.
>> Which DMA engine driver requires this?
>>
>
> dw_dmac.c
>
>> Normally, when we have DMA engine drivers with multiple request signals,
>> the slave peripheral side publishes several virtual channels which are
>> claimed by the peripheral drivers. ?This (amongst other things) allows
>> the peripheral drivers to hold claim to one of the virtual channels
>> all the time that it's required.
>
> If users of DMA expect DMA engine drivers to work this way, then we should
> have this mentioned clearly in DMA slave documentation.

The requirement stems from the fact that most DMACs(esp third party) could be
made to reroute req-signals by the platform, it has not much to do with the API.
IMO, all dmac drivers should be implemented that way to be on the safer side.
