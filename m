From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Jan 2012 09:52:15 +0100
Subject: [PATCH 7/8] dmaengine/dw_dmac: Unmap all memory buffers after
 completion of slave transfers
In-Reply-To: <4F140DB7.3060300@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <5e5d0fcff79b9b78e64c7424317d6b77736eca43.1326707233.git.viresh.kumar@st.com>
 <20120116105448.GT1068@n2100.arm.linux.org.uk>
 <4F140DB7.3060300@st.com>
Message-ID: <CACRpkdY-4wWeD=3mJiChi6+4=iBMcd3kVh3h4JmDZ5ySXY3KCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 12:44 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 1/16/2012 4:24 PM, Russell King - ARM Linux wrote:
>> Note that DMA engine drivers are not responsible for unmapping the buffers
>> when the transfer completes - that is the responsibility of the caller.
>>
>> The automatic buffer unmapping is required for the async_tx APIs and
>> offload APIs.
>
> In dw_dmac, it is only done for slave transfers. Is this Okay ??

Basically the driver using the dmaengine shall map/unmap buffers
used for slave transfers, not the driver.

I usually map them before setting up a transfer and unmaps them
when egtting the callback from the DMA engine that the transfer is
complete.

Why do you want to do this?

Yours,
Linus Walleij
