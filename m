From: haavard.skinnemoen@atmel.com (Haavard Skinnemoen)
Date: Fri, 18 Jun 2010 15:52:34 +0200
Subject: Query dw_dmac driver: All descriptors done, but channel not idle!
In-Reply-To: <4C1B75B7.1080104@st.com>
References: <4C1B75B7.1080104@st.com>
Message-ID: <20100618155234.1fc40ce7@hskinnemoen-d830>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh KUMAR <viresh.kumar@st.com> wrote:
> Can somebody please confirm, if it a known issue or not? Or if there
> are some solutions for this problem.

I'm not aware of any such issue. The code was added as a purely
defensive thing; when writing it, I just thought about what might
happen if we go through all our descriptors without finding the current
one, and added some code to report the issue and try to recover.

I suppose it might be caused by some issue with the peripheral itself,
but I think it's more likely to be caused by some race condition in the
driver, i.e. something goes wrong when inserting or removing
descriptors in the chain.

What might be very good to know at this point is the value of
the llp variable, and perhaps also the value of the CH_EN register to
see if the channel is idle or not.

Haavard
