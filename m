From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 Jan 2012 18:34:56 +0100
Subject: [PATCH 7/8] dmaengine/dw_dmac: Unmap all memory buffers after
 completion of slave transfers
In-Reply-To: <4F153A3E.8010409@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <5e5d0fcff79b9b78e64c7424317d6b77736eca43.1326707233.git.viresh.kumar@st.com>
 <20120116105448.GT1068@n2100.arm.linux.org.uk>
 <4F140DB7.3060300@st.com>
 <CACRpkdY-4wWeD=3mJiChi6+4=iBMcd3kVh3h4JmDZ5ySXY3KCA@mail.gmail.com>
 <4F153A3E.8010409@st.com>
Message-ID: <CACRpkdZWtBq_g7uem8Rsa7nsnGgyDHjd5oy5M_yJeBRnVB41yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 10:07 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

>> Why do you want to do this?
>
> This is because people can pass in flags which are
> DMA_COMPL_SKIP_SRC_UNMAP, etc.
>
> If they are not passed, then DMA driver must do it for them.

OK I see why it's confusing.

That flag is only for memcpy jobs.

Only memcpy jobs maps/unmaps buffers.

Slave transfers are mapped/unmapped by the driver.

Yours,
Linus Walleij
